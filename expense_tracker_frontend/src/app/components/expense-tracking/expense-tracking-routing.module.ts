import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { AddExpensesComponent } from './add-expenses/add-expenses.component';
import { ExpenseListComponent } from './expense-list/expense-list.component';
import { LayoutComponent } from './layout/layout.component';

const routes: Routes = [
  {
    path: '',
    component: LayoutComponent,
    children: [
      { path: 'add-expense', component: AddExpensesComponent },
      { path: 'expense-list', component: ExpenseListComponent },
      { path: '', redirectTo: 'expense-list', pathMatch: 'full' },
    ]
  },
];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class ExpenseTrackingRoutingModule { }
