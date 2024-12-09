import { DecimalPipe } from '@angular/common';
import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup } from '@angular/forms';
import { GlobalService } from '../../../services/global.service';

@Component({
  selector: 'app-add-expenses',
  templateUrl: './add-expenses.component.html',
  styleUrl: './add-expenses.component.css',
  providers: [DecimalPipe]
})
export class AddExpensesComponent implements OnInit {

  search: string = '';
  setBudget: any;
  addExpenses: any = FormGroup;
  today: any;

  budgetAmt: any = 0;
  rimBudgetAmt: any = 0;
  totalExpenses: any = 0;

  expenseDummyList: any = [];

  userId: any;


  constructor(private fb: FormBuilder, private gs: GlobalService) {

  }

  ngOnInit(): void {
    const userDetails = sessionStorage.getItem('userDetails');
    this.userId = userDetails ? JSON.parse(userDetails)?._id : '';
    this.formInit();
  }

  formInit() {
    this.today = new Date().toISOString().split('T')[0];
    this.addExpenses = this.fb.group({
      title: [''],
      amount: [''],
      date: [this.today]
    });
  }

  reset() {
    window.location.reload();
  }

  addBudget() {
    // calculating total budget
    this.budgetAmt += this.setBudget;
    //adding initial level remaining budget
    this.rimBudgetAmt += this.setBudget;
  }

  addExpense() {

    let title = this.addExpenses.get('title').value;
    let amount = this.addExpenses.get('amount').value;
    let date = this.addExpenses.get('date').value;

    if (this.rimBudgetAmt === 0.00) {
      this.gs.showError('Please add budget first..!');
      return;
    }

    if (this.gs.isNotEmpty(title) && this.gs.isNotEmpty(String(amount)) && this.gs.isNotEmpty(date)) {
      // calculating remaining budget
      this.rimBudgetAmt -= this.addExpenses.get('amount').value
      // calculating total expenses
      this.totalExpenses += this.addExpenses.get('amount').value;
      //adding expenses to table
      this.expenseDummyList.push(this.addExpenses.value);
      //resetting expenses
      this.addExpenses.reset();
      //patching default date
      this.addExpenses.patchValue({ date: this.today });
    } else {
      this.gs.showError('Expense details shouldn\'t be empty..!');
    }

  }

  // Function to remove an item using both index and item for verification
  deleteExpense(index: number, itemToDelete: any) {
    const itemAtIndex = this.expenseDummyList[index];
    if (
      itemAtIndex &&
      itemAtIndex.title === itemToDelete.title &&
      itemAtIndex.amount === itemToDelete.amount &&
      itemAtIndex.date === itemToDelete.date
    ) {
      // calculating remaining budget
      this.rimBudgetAmt += itemToDelete.amount;
      // calculating total expenses
      this.totalExpenses -= itemToDelete.amount;
      // Delete item by index
      this.expenseDummyList.splice(index, 1);
    } else {
      console.log('Item verification failed. No deletion performed.');
    }
  }

  editExpense(index: number, itemToEdit: any) {
    const itemAtIndex = this.expenseDummyList[index];
    if (
      itemAtIndex &&
      itemAtIndex.title === itemToEdit.title &&
      itemAtIndex.amount === itemToEdit.amount &&
      itemAtIndex.date === itemToEdit.date
    ) {
      this.addExpenses.patchValue(itemToEdit);
      this.deleteExpense(index, itemToEdit)
    } else {
      console.log('Item verification failed. No editing performed.');
    }

  }


  submitExpenses() {

    let apiUrl = `expenses/addExpenses/${this.userId}`;
    if (this.expenseDummyList.length === 0) {
      this.gs.showError('Expense list is empty. Atleast add one expense..!');
    } else {

      let bdJson = {
        dataToAdd: this.expenseDummyList
      }

      this.gs.postRequest(apiUrl, bdJson).subscribe({
        next: (res: any) => {
          this.gs.showSuccess(res.message)
        },
        error: (e) => {
          console.error('data error:', e);
          this.gs.showError(e.message)
        }
      });
    }

  }
}

