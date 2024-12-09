// src/app/http.interceptor.ts
import { HttpInterceptorFn, HttpRequest, HttpHandlerFn, HttpEvent } from '@angular/common/http';
import { Observable, throwError } from 'rxjs';
import { catchError } from 'rxjs/operators';

export const httpInterceptor: HttpInterceptorFn = (req: HttpRequest<any>, next: HttpHandlerFn): Observable<HttpEvent<any>> => {

  const userDetails = sessionStorage.getItem('userDetails');
  let token = userDetails ? JSON.parse(userDetails)?.token : '';

  // Adding an Authorization header
  const clonedRequest = req.clone({
    setHeaders: {
      "auth-token": token,
      "content-type": "application/json"
    }
  });

  return next(clonedRequest).pipe(
    catchError((error) => {
      console.error('http Interceptor Error:', error);
      return throwError(() => error);
    })
  );
};
