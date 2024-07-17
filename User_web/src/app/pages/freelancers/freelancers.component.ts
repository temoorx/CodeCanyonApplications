/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Handy Service Full App Flutter
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2022-present initappz.
*/
import { Component, OnInit } from '@angular/core';
import { NavigationExtras, Router } from '@angular/router';
import { UtilService } from 'src/app/services/util.service';
import { ApiService } from 'src/app/services/api.service';
import { ProductCartService } from 'src/app/services/product-cart.service';

@Component({
  selector: 'app-freelancers',
  templateUrl: './freelancers.component.html',
  styleUrls: ['./freelancers.component.scss']
})
export class FreelancersComponent implements OnInit {
  categoryList: any[] = [];
  freelancerList: any[] = [];
  productList: any[] = [];
  banners: any[] = [];
  apiCalled: boolean = false;
  haveData: boolean;
  constructor(
    private router: Router,
    public util: UtilService,
    public api: ApiService,
    public productCart: ProductCartService) {
    this.haveData = true;
    this.util.subscribeNewAddress().subscribe(data => {
      this.haveData = true;
      console.log('new address ');
      this.getHomeData();
    });
    this.getHomeData();
  }

  getHomeData() {
    this.apiCalled = false;
    const param = { "lat": localStorage.getItem('lat'), "lng": localStorage.getItem('lng') };
    this.api.post('v1/freelancer/getHomeData', param).then((data: any) => {
      this.apiCalled = true;
      if (data && data.status == 200 && data.havedata == true) {
        this.haveData = true;
        console.log(data);
        this.categoryList = data.categories;
        this.freelancerList = data.data;
        this.productList = data.products;
        data.products.forEach((productList: any) => {
          if (this.productCart.itemId.includes(productList.id)) {
            productList['quantity'] = this.getQuanity(productList.id);
          } else {
            productList['quantity'] = 0;
          }
        });
        this.banners = data.banners;
        console.log(this.banners);
        console.log(this.categoryList);
        console.log(this.freelancerList);
        console.log(this.productList);
      } else {
        this.categoryList = [];
        this.freelancerList = [];
        this.productList = [];
        this.banners = [];
        this.haveData = false;
      }
    }, error => {
      this.apiCalled = true;
      console.log('Error', error);
      this.util.apiErrorHandler(error);
      this.categoryList = [];
      this.freelancerList = [];
      this.productList = [];
      this.banners = [];
      this.haveData = false;
    }).catch(error => {
      this.apiCalled = true;
      console.log('Err', error);
      this.util.apiErrorHandler(error);
      this.categoryList = [];
      this.freelancerList = [];
      this.productList = [];
      this.banners = [];
      this.haveData = false;
    });
  }

  ngOnInit(): void {
  }

  openBanner(item: any) {
    console.log(item);
    if (item.type == 1) {
      console.log('category');
      this.router.navigate(['/service-listing', item.value, 'Offers']);
    } else if (item.type == 2) {
      console.log('single freelancer');
      this.router.navigate(['service', item.value]);
    } else if (item.type == 3) {
      console.log('multiple freelancer');
      localStorage.setItem('top-freelancers', item.value)
      this.router.navigate(['top-freelancers']);
    } else if (item.type == 4) {
      console.log('product category');
      const param: NavigationExtras = {
        queryParams: {
          id: item.value
        }
      };
      this.router.navigate(['shop'], param);
    } else if (item.type == 5) {
      console.log('single product');
      this.router.navigate(['product-detail', item.value]);
    } else if (item.type == 6) {
      console.log('multiple products');
      localStorage.setItem('top-products', item.value)
      this.router.navigate(['top-products']);
    } else {
      console.log('external url');
      window.open(item.value, '_blank');
    }
  }

  onFreelancerDetail(freelancerId: any) {
    this.router.navigate(['service', freelancerId]);
  }

  onProductDetail(productId: any) {
    this.router.navigate(['product-detail', productId]);
  }

  goToProduct() {
    this.router.navigate(['/product']);
  }

  onServiceListing(id: any, name: any) {
    const routeName = name.replace(/[^a-zA-Z0-9]/g, '-').toLowerCase();;
    this.router.navigate(['/service-listing', id, routeName]);
  }

  getAddressName() {
    const location = localStorage.getItem('address');
    if (location && location != null && location !== 'null') {
      return location.length > 30 ? location.slice(0, 30) + '....' : location;;
    }
    localStorage.clear();
    return 'No address';
  }

  getQuanity(id: any) {
    const data = this.productCart.cart.filter(x => x.id == id);
    return data[0].quantity;
  }

  addToCart(index: any) {
    console.log(this.productList[index]);
    if (this.productCart.cart.length == 0) {
      this.productList[index].quantity = 1;
      this.productCart.addItem(this.productList[index]);
    } else {
      if (this.productCart.cart[0].freelacer_id == this.productList[index].freelacer_id) {
        this.productList[index].quantity = 1;
        this.productCart.addItem(this.productList[index]);
      } else {
        this.util.errorMessage(this.util.translate('We already have product with other freelancer'));
      }
    }
  }

  remove(index: any) {
    console.log(this.productList[index]);
    if (this.productList[index].quantity == 1) {
      this.productList[index].quantity = 0;
      this.productCart.removeItem(this.productList[index].id);
    } else {
      this.productList[index].quantity = this.productList[index].quantity - 1;
      this.productCart.updateQuantity(this.productList[index].id, this.productList[index].quantity);
    }
  }

  add(index: any) {
    console.log(this.productList[index]);
    this.productList[index].quantity = this.productList[index].quantity + 1;
    this.productCart.updateQuantity(this.productList[index].id, this.productList[index].quantity);
  }
}
