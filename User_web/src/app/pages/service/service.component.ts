/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Handy Service Full App Flutter
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2022-present initappz.
*/
import { Component, OnInit } from '@angular/core';
import { ActivatedRoute, NavigationExtras, Router } from '@angular/router';
import { ApiService } from 'src/app/services/api.service';
import { ProductCartService } from 'src/app/services/product-cart.service';
import { ServiceCartService } from 'src/app/services/service-cart.service';
import { UtilService } from 'src/app/services/util.service';

@Component({
  selector: 'app-service',
  templateUrl: './service.component.html',
  styleUrls: ['./service.component.scss']
})
export class ServiceComponent implements OnInit {
  currentTab = '1';

  freelancerId: any = '';

  freelancerCover: any = '';
  freelancerName: any = '';
  totalExperience: any = 0;
  rating: any = 0;
  totalRating: any = 0;
  descriptions: any = '';
  duration: any = 0;
  email: any = '';
  mobile: any = '';
  country_code: any = '';
  gallary: any[] = [];

  serviceList: any[] = [];
  reviewList: any[] = [];
  productList: any[] = [];

  profileCalled: boolean = false;
  servicesCalled: boolean = false;
  reviewsCalled: boolean = false;
  productsCalled: boolean = false;

  constructor(
    private router: Router,
    public util: UtilService,
    public api: ApiService,
    private navParam: ActivatedRoute,
    public serviceCart: ServiceCartService,
    public productCart: ProductCartService) {
    if (this.navParam.snapshot.paramMap.get('id')) {
      this.freelancerId = this.navParam.snapshot.paramMap.get('id');
      this.getFreelancerByID();
    }
  }

  getFreelancerByID() {
    this.profileCalled = false;
    this.api.post('v1/freelancer/getByUID', { "id": this.freelancerId }).then((data: any) => {
      console.log(data);
      this.profileCalled = true;
      if (data && data.status == 200) {
        this.freelancerCover = data.data.cover;
        this.freelancerName = data.data.name;
        this.totalExperience = data.data.total_experience;
        this.rating = data.data.rating;
        this.totalRating = data.data.total_rating;
        this.descriptions = data.data.descriptions;
        this.duration = data.data.duration;
        this.email = data.data.user_info.email;
        this.mobile = data.data.user_info.mobile;
        this.country_code = data.data.user_info.country_code;
        console.log(typeof data.data.gallery);
        if (((x) => { try { JSON.parse(x); return true; } catch (e) { return false } })(data.data.gallery)) {
          const gallery = JSON.parse(data.data.gallery);
          this.gallary = [];
          gallery.forEach(element => {
            if (element != '') {
              this.gallary.push(element);
            }
          });
        } else {
          this.gallary = [];
        }
        this.getFreelancerServices();
        console.log(this.gallary);
      }
    }, error => {
      console.log('Error', error);
      this.profileCalled = true;
      this.util.apiErrorHandler(error);
    }).catch(error => {
      console.log('Err', error);
      this.profileCalled = true;
      this.util.apiErrorHandler(error);
    });
  }

  getFreelancerServices() {
    this.servicesCalled = false;
    this.api.post('v1/freelancer_services/getFreelancerServices', { "id": this.freelancerId }).then((data: any) => {
      console.log(data);
      this.servicesCalled = true;
      if (data && data.status == 200) {
        this.serviceList = data.data;
        this.serviceList.forEach(element => {
          if (this.serviceCart.itemId.includes(element.id)) {
            element['isChecked'] = true;
          } else {
            element['isChecked'] = false;
          }
        })
        console.log(this.serviceList);
      }
    }, error => {
      console.log('Error', error);
      this.servicesCalled = true;
      this.util.apiErrorHandler(error);
    }).catch(error => {
      console.log('Err', error);
      this.servicesCalled = true;
      this.util.apiErrorHandler(error);
    });
  }

  addService(item: any) {
    item.isChecked = true;
    this.serviceCart.addItem(item);
  }

  removeService(item: any) {
    item.isChecked = false;
    this.serviceCart.removeItem(item.id);
  }

  getAllFreelancerReviews() {
    this.reviewsCalled = false;
    this.api.post('v1/freelancer_reviews/getMyReviews', { "id": this.freelancerId }).then((data: any) => {
      console.log(data);
      this.reviewsCalled = true;
      if (data && data.status == 200) {
        this.reviewList = data.data;
        console.log(this.reviewList);
      }
    }, error => {
      console.log('Error', error);
      this.reviewsCalled = true;
      this.util.apiErrorHandler(error);
    }).catch(error => {
      console.log('Err', error);
      this.reviewsCalled = true;
      this.util.apiErrorHandler(error);
    });
  }

  ngOnInit(): void {
  }

  goToCheckout() {
    const uid = localStorage.getItem('uid');
    if (uid && uid != null && uid !== 'null') {
      this.router.navigate(['/checkout']);
    } else {
      this.util.publishModalPopup('login');
    }
  }

  goToProductCheckout() {
    const uid = localStorage.getItem('uid');
    if (uid && uid != null && uid !== 'null') {
      this.router.navigate(['/product-checkout']);
    } else {
      this.util.publishModalPopup('login');
    }

  }

  getAllProducts() {
    this.productsCalled = false;
    this.api.post('v1/products/getFreelancerProducts', { "id": this.freelancerId, }).then((data: any) => {
      console.log(data);
      this.productsCalled = true;
      if (data && data.status == 200) {
        if (data && data.data && data.data.length > 0) {
          data.data.forEach((productList: any) => {
            if (this.productCart.itemId.includes(productList.id)) {
              productList['quantity'] = this.getQuanity(productList.id);
            } else {
              productList['quantity'] = 0;
            }
          });
        }
        this.productList = data.data;
        console.log('productlist ------------------', this.productList);
      }
    }, error => {
      console.log('Error', error);
      this.productsCalled = true;
      this.util.apiErrorHandler(error);
    },
    ).catch(error => {
      console.log('Err', error);
      this.productsCalled = true;
      this.util.apiErrorHandler(error);
    });
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

  getQuanity(id: any) {
    const data = this.productCart.cart.filter(x => x.id == id);
    return data[0].quantity;
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

  clearServiceCart() {
    this.serviceCart.clearCart();
    this.serviceList.forEach((element) => {
      element.isChecked = false;
    });
  }

  clearProductCart() {
    this.productCart.clearCart();
    this.productList.forEach((element) => {
      element.quantity = 0;
    });
  }

  changeTab(id: any) {
    this.currentTab = id;
    console.log(this.currentTab);
    if (this.currentTab == '1') {
      console.log('services');
      this.getFreelancerServices();
    } else if (this.currentTab == '2') {
      console.log('shop');
      this.getAllProducts();
    } else if (this.currentTab == '3') {
      console.log('reviews');
      this.getAllFreelancerReviews();
    } else if (this.currentTab == '4') {
      console.log('overviews')
    } else if (this.currentTab == '5') {
      console.log('gallery');
    }
  }

  openProduct(productId: any) {
    console.log('open product', productId);
    this.router.navigate(['product-detail', productId]);
  }
}
