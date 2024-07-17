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
  selector: 'app-orders-details',
  templateUrl: './orders-details.component.html',
  styleUrls: ['./orders-details.component.scss']
})
export class OrdersDetailsComponent implements OnInit {
  id: any = '';
  apiCalled: boolean = false;
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
  date_time: any = '';
  addressName = ['home', 'work', 'other'];  // 1 = home , 2 = work , 3 = other
  paymentBy = ['NA', 'COD', 'Stripe', 'PayPal', 'PayTM', 'Razorpay', 'Instamojo', 'Paystack', 'Flutterwave'];
  freelancerCover: any = '';
  freelancerName: any = '';
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
    this.api.post_private('v1/product_order/getById', { id: this.id }).then((data: any) => {
      console.log(data);
      this.apiCalled = true;
      if (data && data.status && data.status == 200 && data.data && data.data.id) {
        const info = data.data;
        if (((x) => { try { JSON.parse(x); return true; } catch (e) { return false } })(info.orders)) {
          this.orders = JSON.parse(info.orders);
          console.log(this.orders);
        } else {
          this.orders = [];
        }
        if (info.order_to == 1 || info.order_to == '1') {
          if (((x) => { try { JSON.parse(x); return true; } catch (e) { return false } })(info.address)) {
            var address = JSON.parse(info.address);
            console.log(address);
            this.address = address.house + ' ' + address.landmark + ' ' + address.address + ' ' + address.pincode;
            this.myLat = address.lat;
            this.myLng = address.lng;
          }
        }

        if (info && info.freelancerInfo) {
          this.freelancerCover = info.freelancerInfo.cover;
          this.freelancerName = info.freelancerInfo.first_name + ' ' + info.freelancerInfo.last_name;
        }

        this.itemTotal = info.total;
        this.taxCharge = info.tax;
        this.distance_cost = info.delivery_charge;
        this.discount = info.discount;
        this.grand_total = info.grand_total;
        this.pay_method = info.paid_method;
        this.wallet_price = info.wallet_price;
        this.wallet_used = info.wallet_used;
        this.date_time = moment(info.date_time).format('llll');
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
    window.open(this.api.baseUrl + 'v1/product_order/printInvoice?id=' + this.id + '&token=' + localStorage.getItem('token'), '_blank');
  }
}
