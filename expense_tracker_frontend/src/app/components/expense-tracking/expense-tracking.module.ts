import { CUSTOM_ELEMENTS_SCHEMA, NgModule } from '@angular/core';
import { CommonModule, DecimalPipe } from '@angular/common';

import { ExpenseTrackingRoutingModule } from './expense-tracking-routing.module';
import { LayoutComponent } from './layout/layout.component';
import { AddExpensesComponent } from './add-expenses/add-expenses.component';
import { ExpenseListComponent } from './expense-list/expense-list.component';
import { NgxDatatableModule } from '@swimlane/ngx-datatable';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { provideHttpClient, withInterceptors } from '@angular/common/http';
import { httpInterceptor } from '../../services/http.interceptor';


@NgModule({
  declarations: [
    LayoutComponent,
    AddExpensesComponent,
    ExpenseListComponent,
  ],
  imports: [
    CommonModule,
    ExpenseTrackingRoutingModule,
    NgxDatatableModule,
    FormsModule,
    ReactiveFormsModule,
  ],
  schemas: [CUSTOM_ELEMENTS_SCHEMA],
  providers: [

  ]
})
export class ExpenseTrackingModule { }

