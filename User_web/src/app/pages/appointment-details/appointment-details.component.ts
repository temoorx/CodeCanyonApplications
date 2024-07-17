/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Handy Service Full App Flutter
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2022-present initappz.
*/
import { Component, OnInit } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import * as moment from 'moment';
import { ApiService } from 'src/app/services/api.service';
import { UtilService } from 'src/app/services/util.service';

@Component({
  selector: 'app-appointment-details',
  templateUrl: './appointment-details.component.html',
  styleUrls: ['./appointment-details.component.scss']
})
export class AppointmentDetailsComponent implements OnInit {
  id: any = '';
  orders: any[] = [];
  address: any = '';
  myLat: any = '';
  myLng: any = '';
  itemTotal: any = 0;
  taxCharge: any = 0;
  distance_cost: any = 0;
  discount: any = 0;
  grand_total: any = 0;
  wallet_price: any = 0;
  pay_method: any = 0;
  status: any = 0;
  wallet_used: any = 0;
  save_date: any = '';
  addressName = ['home', 'work', 'other'];  // 1 = home , 2 = work , 3 = other

  freelancerCover: any = '';
  freelancerName: any = '';
  freelancerMobile: any = '';
  freelancerEmail: any = '';
  apiCalled: boolean = false;
  paymentBy = ['NA', 'COD', 'Stripe', 'PayPal', 'PayTM', 'Razorpay', 'Instamojo', 'Paystack', 'Flutterwave']
  constructor(
    public util: UtilService,
    public api: ApiService,
    private route: ActivatedRoute
  ) {
    this.id = this.route.snapshot.paramMap.get('id');
    console.log(this.id);
    if (this.id && this.id != '' && this.id != null) {
      this.getInfo();
    }

  }

  ngOnInit(): void {
  }

  getInfo() {
    this.apiCalled = false;
    this.api.post_private('v1/appointments/getById', { id: this.id }).then((data: any) => {
      console.log(data);
      this.apiCalled = true;
      if (data && data.status && data.status == 200 && data.data && data.data.id) {
        const info = data.data;
        if (((x) => { try { JSON.parse(x); return true; } catch (e) { return false } })(info.items)) {
          this.orders = JSON.parse(info.items);
          console.log(this.orders);
        } else {
          this.orders = [];
        }
        if (((x) => { try { JSON.parse(x); return true; } catch (e) { return false } })(info.address)) {
          var address = JSON.parse(info.address);
          console.log(address);
          this.address = address.house + ' ' + address.landmark + ' ' + address.address + ' ' + address.pincode;
          this.myLat = address.lat;
          this.myLng = address.lng;
        }

        if (info && info.freelancer) {
          this.freelancerCover = info.freelancer.cover;
          this.freelancerName = info.freelancer.name;
          this.freelancerEmail = info.freelancer.email;
          this.freelancerMobile = info.mobile;
        }

        this.itemTotal = info.total;
        this.taxCharge = info.serviceTax;
        this.distance_cost = info.distance_cost;
        this.discount = info.discount;
        this.grand_total = info.grand_total;
        this.pay_method = info.pay_method;
        this.wallet_price = info.wallet_price;
        this.wallet_used = info.wallet_used;
        this.save_date = moment(info.save_date).format('llll') + ' ' + info.slot;
        this.status = info.status;
      }
    }, error => {
      console.log(error);
      this.apiCalled = true;
      this.util.apiErrorHandler(error);
    }).catch((error: any) => {
      console.log(error);
      this.apiCalled = true;
      this.util.apiErrorHandler(error);
    });
  }

  printInvoice() {
    window.open(this.api.baseUrl + 'v1/appointments/printInvoice?id=' + this.id + '&token=' + localStorage.getItem('token'), '_blank');
  }

}
