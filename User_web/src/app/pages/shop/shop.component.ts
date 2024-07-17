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
import { UtilService } from 'src/app/services/util.service';


@Component({
  selector: 'app-shop',
  templateUrl: './shop.component.html',
  styleUrls: ['./shop.component.scss']
})
export class ShopComponent implements OnInit {
  categoryList: any[] = [];
  subCategoryList: any[] = [];
  productList: any[] = [];
  cateID: any = '';
  subCateID: any = '';
  productId: any = '';
  topProducts: any[] = [];

  categoryCalled: boolean = false;
  subCategoryCalled: boolean = false;
  productsCalled: boolean = false;

  inOffer: boolean = false;

  constructor(private router: Router,
    public util: UtilService,
    public api: ApiService,
    private navParam: ActivatedRoute,
    public productCart: ProductCartService) {
    this.navParam.queryParams.subscribe((data: any) => {
      console.log(data);
      if (data && data.id) {
        this.cateID = data.id;
        this.inOffer = true;
      } else {
        this.inOffer = false;
      }
    });
    this.getAllCategories();
  }

  onCateId(cateID: any) {
    this.cateID = cateID;
    this.getAllSubCategories();
  }

  onSubCateId(subCateID: any) {
    this.subCateID = subCateID;
    this.getAllProducts();
  }

  onProductDetail(productId: any) {
    this.router.navigate(['product-detail', productId]);
  }


  getAllCategories() {
    this.categoryCalled = false;
    this.categoryList = [];
    this.api.get('v1/product_categories/for_user').then((data: any) => {
      console.log(data);
      this.categoryCalled = true;
      if (data && data.status == 200) {
        this.categoryList = data.data;
        if (this.categoryList.length > 0) {
          if (this.inOffer == false) {
            this.cateID = this.categoryList[0].id;
          }
          this.getAllSubCategories();
        }
        console.log(this.categoryList);
      }
    }, error => {
      this.categoryCalled = true;
      console.log('Error', error);
      this.util.apiErrorHandler(error);
    }).catch(error => {
      this.categoryCalled = true;
      console.log('Err', error);
      this.util.apiErrorHandler(error);
    });
  }

  getAllSubCategories() {
    this.subCategoryCalled = false;
    this.subCategoryList = [];
    this.api.post('v1/product_sub_categories/getbycate', { "id": this.cateID }).then((data: any) => {
      this.subCategoryCalled = true;
      console.log(data);
      if (data && data.status == 200) {
        this.subCategoryList = data.data;
        if (this.subCategoryList.length > 0) {
          this.subCateID = this.subCategoryList[0].id;
          this.getAllProducts();
        }
        console.log(this.subCategoryList);
      }
    }, error => {
      console.log('Error', error);
      this.subCategoryCalled = true;
      this.util.apiErrorHandler(error);
    }).catch(error => {
      console.log('Err', error);
      this.subCategoryCalled = true;
      this.util.apiErrorHandler(error);
    });
  }

  getAllProducts() {
    this.productList = [];
    this.productsCalled = false;
    this.api.post('v1/products/getByCateAndSubCate', { "cate_id": this.cateID, "sub_cate_id": this.subCateID }).then((data: any) => {
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
      this.productsCalled = true;
      console.log('Error', error);
      this.util.apiErrorHandler(error);
    }).catch(error => {
      this.productsCalled = true;
      console.log('Err', error);
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

  ngOnInit(): void {
  }

  goToProductDetail() {
    this.router.navigate(['/product-detail']);
  }

}
