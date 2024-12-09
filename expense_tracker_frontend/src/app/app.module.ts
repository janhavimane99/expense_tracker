import { NgModule } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';

import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';
import { SignUpComponent } from './components/sign-up/sign-up.component';
import { SignInComponent } from './components/sign-in/sign-in.component';
import { AddExpensesComponent } from './components/expense-tracking/add-expenses/add-expenses.component';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { HttpClient, provideHttpClient, withInterceptors } from '@angular/common/http';
import { GlobalService } from './services/global.service';
import { provideToastr, ToastrModule } from 'ngx-toastr';
import { BrowserAnimationsModule } from '@angular/platform-browser/animations';
import { httpInterceptor } from './services/http.interceptor';

@NgModule({
  declarations: [
    AppComponent,
    SignUpComponent,
    SignInComponent
  ],
  imports: [
    BrowserModule,
    AppRoutingModule,
    FormsModule,
    ReactiveFormsModule,
    BrowserAnimationsModule,
    ToastrModule.forRoot({
      timeOut: 5000,
      positionClass: 'toast-top-right',
      preventDuplicates: true,
    }),
  ],
  providers: [
    provideToastr(), GlobalService,
    provideHttpClient(
      withInterceptors([httpInterceptor]) // Registering the interceptor here
    ),
  ],
  bootstrap: [AppComponent]
})
export class AppModule { }
