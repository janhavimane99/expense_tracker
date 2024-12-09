import { Component, OnInit, ViewEncapsulation } from '@angular/core';
import { ColumnMode, SelectionType } from '@swimlane/ngx-datatable';
import { GlobalService } from '../../../services/global.service';
import { DatePipe } from '@angular/common';

@Component({
  selector: 'app-expense-list',
  templateUrl: './expense-list.component.html',
  styleUrl: './expense-list.component.css',
  providers: [DatePipe]
})
export class ExpenseListComponent implements OnInit {

  columns = ColumnMode.force;
  checkbox = SelectionType.checkbox;
  data: any = [];
  filterList: any = [];
  selected = [];

  //filter variables
  search: any;
  toDate: any;
  fromDate: any;


  constructor(private gs: GlobalService, private datePipe: DatePipe) { }

  ngOnInit(): void {
    this.getData();
  }

  clear() {
    this.toDate = undefined;
    this.fromDate = undefined;
    this.search = undefined;
    this.getData();
  }

  getData() {
    const userDetails = sessionStorage.getItem('userDetails');
    let userId = userDetails ? JSON.parse(userDetails)?._id : '';

    let bdJson = {}

    if (this.gs.isNotEmpty(this.toDate) && this.gs.isNotEmpty(this.fromDate)) {
      bdJson = {
        "toDate": this.toDate,
        "fromDate": this.fromDate
      }
    }


    if (this.gs.isNotEmpty(userId)) {
      let apiUrl = `expenses/expenseList/${userId}`;

      this.gs.postRequest(apiUrl, bdJson).subscribe({
        next: (res: any) => {
          this.data = res?.data.map((item: any) => ({
            ...item,
            date: this.datePipe.transform(item.date, 'yyyy-MM-dd')  // Format the date
          }));
          this.filterList = [...this.data];
        },
        error: (e) => {
          console.error('data error:', e);
          this.gs.showError(e.message)
        }
      });
    } else {
      this.gs.showError('User Is Not Available..!');
    }

  }

  deleteExpense(id: any) {

    let apiUrl = `expenses/deleteExpense/${id}`;
    console.log(apiUrl);

    this.gs.deleteRequest(apiUrl).subscribe({
      next: (res: any) => {
        this.gs.showSuccess(res?.message)
        this.getData();
      },
      error: (e) => {
        console.error('data error:', e);
        this.gs.showError(e.error.message)
      }
    });

  }

  filter(event: any) {

    if (this.gs.isNotEmpty(event)) {
      this.data = this.filterList.filter((item: any) => {
        if (this.gs.isNotEmpty(item?.title) &&
          item?.title?.toUpperCase().indexOf(event?.toUpperCase()) !== -1) {
          return true;
        } else if (this.gs.isNotEmpty(item?.date) &&
          item?.date?.toUpperCase().indexOf(event?.toUpperCase()) !== -1) {
          return true;
        } else if (this.gs.isNotEmpty(item?.amount) &&
          String(item?.amount)?.indexOf(event) !== -1) {
          return true;
        } else {
          return false;
        }
      })
    } else {
      this.data = this.filterList;
    }
  }

}

