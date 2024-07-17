/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Handy Service Full App Flutter
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2022-present initappz.
*/
import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { ServiceRoutingModule } from './service-routing.module';
import { ServiceComponent } from './service.component';
import { CarouselModule } from 'ngx-owl-carousel-o';
import { MDBBootstrapModule } from 'angular-bootstrap-md';
import { NgxPaginationModule } from 'ngx-pagination';
import { NgxSkeletonLoaderModule } from 'ngx-skeleton-loader';

@NgModule({
  declarations: [
    ServiceComponent
  ],
  imports: [
    CommonModule,
    ServiceRoutingModule,
    CarouselModule,
    MDBBootstrapModule.forRoot(),
    NgxPaginationModule,
    NgxSkeletonLoaderModule
  ]
})
export class ServiceModule { }
