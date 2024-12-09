import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { ToastrService } from 'ngx-toastr';
import { map, pipe } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class GlobalService {

  api = "http://localhost:3000/api/";

  constructor(private http: HttpClient, private toaster: ToastrService) { }

  getRequest(paramUrl: any) {
    let url = this.api + paramUrl;
    return this.http.get(url);
  }

  postRequest(paramUrl: any, obj: {}) {
    let url = this.api + paramUrl;
    return this.http.post(url, obj);
  }

  deleteRequest(paramUrl: any) {
    let url = this.api + paramUrl;
    return this.http.delete(url);
  }

  showSuccess(msg: string) {
    this.toaster.success(msg, "SUCCESS")
  }

  showError(msg: string) {
    this.toaster.error(msg, "Error")
  }

  isNotEmpty(str: any) {
    if (str === null || str === undefined || /^\s*$/.test(str)) {
      return false;
    }
    return true;
  }


}
