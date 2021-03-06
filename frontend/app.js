import 'babel-polyfill';
import React from 'react';
import {render} from 'react-dom';

import {Admin, Resource, Delete, englishMessages, jsonRest} from './src/index';
import frenchMessages from 'aor-language-french';

//import addUploadFeature from './addUploadFeature';

import {GroupList, GroupCreate, GroupEdit, GroupShow} from './resources/groups';
import {CustomerList, CustomerEdit, CustomerCreate, CustomerShow, CustomerIcon} from './resources/customers';
import {EmployeeList, EmployeeEdit, EmployeeCreate, EmployeeShow, EmployeeIcon} from './resources/employees';
import {ProductList, ProductEdit, ProductShow, ProductCreate} from './resources/products';
import {CategoryList, CategoryEdit, CategoryShow, CategoryCreate} from './resources/categories';
import {OrderList, OrderEdit, OrderShow, OrderCreate} from './resources/orders';
import {OrderDetailList, OrderDetailEdit, OrderDetailShow, OrderDetailCreate} from './resources/orderDetails';
import {PolicyList, PolicyEdit, PolicyShow, PolicyCreate} from './resources/policies';

import * as customMessages from './i18n';
import authClient from './authClient';

const messages = {
  fr: {...frenchMessages, ...customMessages.fr},
  en: {...englishMessages, ...customMessages.en}
};

const restClient = jsonRest('api');
//const uploadCapableClient = addUploadFeature(restClient);

render(
  <Admin theme={{button: {
      textTransform: 'initial'
    },}} authClient={authClient} restClient={restClient} title="Application" locale="en" messages={messages}>
    <Resource name="customers" list={CustomerList} create={CustomerCreate} edit={CustomerEdit} remove={Delete}
              show={CustomerShow}
              icon={CustomerIcon}/>
    <Resource name="employees" list={EmployeeList} create={EmployeeCreate} edit={EmployeeEdit} remove={Delete}
              show={EmployeeShow}
              icon={EmployeeIcon}/>
    <Resource name="groups" list={GroupList} create={GroupCreate} edit={GroupEdit} show={GroupShow} remove={Delete}/>
    <Resource name="products" list={ProductList} create={ProductCreate} edit={ProductEdit} show={ProductShow}
              remove={Delete}/>
    <Resource name="categories" list={CategoryList} create={CategoryCreate} edit={CategoryEdit} show={CategoryShow}
              remove={Delete}/>
    <Resource name="orders" list={OrderList} create={OrderCreate} edit={OrderEdit} show={OrderShow} remove={Delete}/>
    <Resource name="orderdetail" list={OrderDetailList} create={OrderDetailCreate} edit={OrderDetailEdit}
              show={OrderDetailShow} remove={Delete}/>
    <Resource name="policies" list={PolicyList} create={PolicyCreate} edit={PolicyEdit}
              show={PolicyShow} remove={Delete}/>
  </Admin>,
  document.getElementById('root')
);
