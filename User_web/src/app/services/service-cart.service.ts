/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Handy Service Full App Flutter
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2022-present initappz.
*/
import { Injectable } from '@angular/core';
import { ApiService } from './api.service';
import { UtilService } from './util.service';


@Injectable({
  providedIn: 'root'
})
export class ServiceCartService {

  public cart: any[] = [];
  public itemId: any[] = [];
  public totalPrice: any = 0;
  public grandTotal: any = 0;
  public coupon: any;
  public serviceTax: any = 0;
  public discount: any = 0;
  public orderTax: any = 0;
  public orderPrice: any;
  public minOrderPrice: any = 0;
  public freeShipping: any = 0;
  public datetime: any;
  public deliveredAddress: any;

  public storeInfo: any;

  public shippingMethod: 0;
  public shippingPrice: 0;
  public deliveryCharge: any = 0.0;
  public totalItemsInCart: any;

  public deliveryPrice: any = 0;
  public stores: any[] = [];
  public totalItem: any;
  public bulkOrder: any[] = [];
  public flatTax: any;
  public cartStoreInfo: any;

  public havePayment: boolean;
  public haveStripe: boolean;
  public haveRazor: boolean;
  public haveCOD: boolean;
  public havePayPal: boolean;
  public havePayTM: boolean;
  public havePayStack: boolean;
  public haveFlutterwave: boolean;

  public walletDiscount: any = 0.0;
  constructor(
    public util: UtilService,
    public api: ApiService
  ) {
    this.util.getKeys('userCart').then((data: any) => {
      console.log('*******************************************', data);
      if (data && data !== null && data !== 'null') {
        const userCart = JSON.parse(data);
        if (userCart && userCart.length > 0) {
          this.cart = userCart;
          this.itemId = [...new Set(this.cart.map(item => item.id))];
          if (this.cart.length > 0) {
            this.getFreelancerByID();
          }
          this.calcuate();
          console.log('0???', userCart);
        } else {
          console.log('1???', data);
          this.calcuate();
        }
      } else {
        console.log('2???', data);
        this.calcuate();
      }
    });
  }


  getFreelancerByID() {
    const param = {
      id: this.cart[0].uid
    };

    this.api.post('v1/freelancer/getByUID', param).then((data: any) => {
      if (data && data.status == 200) {
        console.log(data);
        this.storeInfo = data.data;
      }
    }, error => {
      console.log('Error', error);
      this.util.apiErrorHandler(error);
    }).catch(error => {
      console.log('Err', error);
      this.util.apiErrorHandler(error);
    });
  }

  calcuate() {

    let total = 0;
    this.cart.forEach(element => {
      if (element.discount > 0) {
        total = total + element.off;
      } else {
        total = total + element.price;
      }
    });
    this.totalPrice = total;
    console.log(this.totalPrice);
    // AKHAND
    localStorage.removeItem('userCart');
    localStorage.setItem('userCart', JSON.stringify(this.cart));
    this.util.clearKeys('userCart');
    this.util.setKeys('userCart', JSON.stringify(this.cart));
    // AKHAND
    this.totalPrice = parseFloat(this.totalPrice).toFixed(1);
    this.orderTax = parseFloat(this.orderTax).toFixed(1);
    this.discount = parseFloat(this.discount).toFixed(1);

    this.calculateAllCharges();
  }



  addItem(item: any) {
    console.log('item to adde', item);
    this.cart.push(item);
    this.itemId.push(item.id);
    this.calcuate();
  }

  removeItem(id: any) {
    console.log('remove this item from cart');
    console.log('current cart items', this.cart);
    this.cart = this.cart.filter(x => x.id !== id);
    this.itemId = this.itemId.filter(x => x !== id);

    console.log('===>>>>>>>>>', this.cart);
    console.log('items===>>>', this.itemId);
    this.calcuate();
  }


  calculateAllCharges() {

    console.log(this.totalPrice, this.orderTax, this.deliveryCharge);
    let total = parseFloat(this.totalPrice) + parseFloat(this.orderTax.toString()) + parseFloat(this.deliveryCharge);

    if (this.coupon && this.coupon.discount && this.coupon.discount > 0) {
      function percentage(numFirst: any, per: any) {
        return (numFirst / 100) * per;
      }
      this.discount = percentage(this.totalPrice, this.coupon.discount);
      this.discount = parseFloat(this.discount).toFixed(1);
      if (total <= this.discount) {
        this.discount = this.totalPrice;
        total = total - this.discount;
      } else {
        total = total - this.discount;
      }
    }


    console.log('sub totall', total);
    this.grandTotal = total;
    let totalPrice = parseFloat(this.totalPrice) + parseFloat(this.orderTax) + parseFloat(this.deliveryCharge);
    console.log(totalPrice);
    this.grandTotal = totalPrice;
    this.grandTotal = totalPrice - this.discount;
    this.grandTotal = parseFloat(this.grandTotal).toFixed(2);
    if (this.grandTotal <= this.walletDiscount) {
      this.walletDiscount = this.grandTotal;
      this.grandTotal = this.grandTotal - this.walletDiscount;
    } else {
      this.grandTotal = this.grandTotal - this.walletDiscount;
    }
  }

  clearCart() {
    this.cart = [];
    this.itemId = [];
    this.totalPrice = 0;
    this.grandTotal = 0;
    this.coupon = undefined;
    this.discount = 0;
    this.orderPrice = 0;
    this.datetime = undefined;
    this.stores = [];
    this.util.clearKeys('userCart');
    this.totalItem = 0;
    this.deliveryCharge = 0;
    this.deliveredAddress = null;
  }
}
