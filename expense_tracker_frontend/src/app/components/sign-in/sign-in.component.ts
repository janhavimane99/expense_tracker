import { Component, OnInit } from '@angular/core';
import { AbstractControl, FormBuilder, FormGroup, Validators } from '@angular/forms';
import { Router } from '@angular/router';
import Validation from '../../services/validation';
import { GlobalService } from '../../services/global.service';

@Component({
  selector: 'app-sign-in',
  templateUrl: './sign-in.component.html',
  styleUrl: './sign-in.component.css'
})
export class SignInComponent implements OnInit {

  loginForm: FormGroup | any;
  submitted = false;

  constructor(public formBuilder: FormBuilder, private gs: GlobalService, private router: Router) { }

  ngOnInit(): void {
    this.formInit();
  }

  formInit() {
    this.loginForm = this.formBuilder.group({
      username: ['', Validators.required],
      password: ['', Validators.required]
    });
  }

  get f(): { [key: string]: AbstractControl } {
    return this.loginForm.controls;
  }

  submitForm() {
    this.submitted = true;

    if (this.loginForm.invalid) {
      return;
    }

    let bdJscon = {
      username: this.loginForm.get('username').value,
      password: this.loginForm.get('password').value
    }

    this.gs.postRequest('user/login', bdJscon).subscribe({
      next: (res: any) => {
        // Handle successful signup (e.g., navigate to login page)
        console.log('Signup successful:', res);

        let userDetails = {
          "username": res?.username,
          "_id": res?._id,
          "token": res?.token
        }
        sessionStorage.setItem('userDetails', JSON.stringify(userDetails));
        this.router.navigate(['/track']);
      },
      error: (e) => {
        console.error('Signup error:', e);
        this.gs.showError(e.error.message)
      },
      complete: () => {
        console.info('Signup request completed');
        this.gs.showSuccess('User Logged In Sucessfully!')
      }
    });
  }


}
