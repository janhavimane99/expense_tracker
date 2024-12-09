import { Component, OnInit } from '@angular/core';
import { AbstractControl, EmailValidator, FormBuilder, FormGroup, Validators } from '@angular/forms';
import { GlobalService } from '../../services/global.service';
import Validation from '../../services/validation';
import { Router } from '@angular/router';

@Component({
  selector: 'app-sign-up',
  templateUrl: './sign-up.component.html',
  styleUrl: './sign-up.component.css'
})
export class SignUpComponent implements OnInit {

  signUpForm: FormGroup | any;
  passwordVisible = false;
  confirmPasswordVisible = false;
  submitted = false;

  constructor(public formBuilder: FormBuilder, private gs: GlobalService, private router: Router) { }

  ngOnInit(): void {
    this.formInit();
  }

  formInit() {
    this.signUpForm = this.formBuilder.group({
      username: ['', Validators.required],
      emailId: ['', [Validators.required, Validators.email]],
      password: ['', Validators.required],
      confirmPassword: ['', Validators.required]
    },
      {
        validators: [Validation.match('password', 'confirmPassword')],
      }
    );
  }

  get f(): { [key: string]: AbstractControl } {
    return this.signUpForm.controls;
  }

  togglePasswordVisibility() {
    this.passwordVisible = !this.passwordVisible;  // Toggle between true and false
  }
  toggleConfirmPasswordVisibility() {
    this.confirmPasswordVisible = !this.confirmPasswordVisible;  // Toggle between true and false
  }

  submitForm() {
    this.submitted = true;

    if (this.signUpForm.invalid) {
      return;
    }

    let bdJson = {
      "username": this.signUpForm.get('username').value,
      "emailId": this.signUpForm.get('emailId').value,
      "password": this.signUpForm.get('password').value
    }

    let confirmPassword = this.signUpForm.get('confirmPassword').value

    if (bdJson.password === confirmPassword) {

      this.gs.postRequest('user/signup', bdJson).subscribe({
        next: (res: any) => {
          console.log('Signup successful:', res);

          if (res.message.includes("User Already Exists..!")) {
            this.gs.showError(res?.message);
            return;
          }
          // this.router.navigate(['/login']);
          this.gs.showSuccess(res?.message);
        },
        error: (e) => {
          console.error('Signup error:', e);
        },
        complete: () => {
          console.info('Signup request completed');
        }
      });

    } else {
      this.gs.showError('password and confirm password did not matches.!');
    }
  }


}
