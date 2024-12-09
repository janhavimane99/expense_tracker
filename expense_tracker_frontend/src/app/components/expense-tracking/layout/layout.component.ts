import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';

@Component({
  selector: 'app-layout',
  templateUrl: './layout.component.html',
  styleUrl: './layout.component.css'
})
export class LayoutComponent implements OnInit {

  userName: any;

  constructor(public router: Router) {

  }

  ngOnInit(): void {
    const userDetails = sessionStorage.getItem('userDetails');
    this.userName = userDetails ? JSON.parse(userDetails)?.username : '';
  }

  logout() {
    sessionStorage.removeItem('userDetails');
    this.router.navigate(['/login']);
  }

}
