import 'package:flutter/material.dart';
import 'package:zmz_app/utils/z_fit.dart';

class ZRadius {

  static BorderRadius get all_3 => BorderRadius.all(Radius.circular(ZFit().setWidth(3)));

  static BorderRadius get all_5 => BorderRadius.all(Radius.circular(ZFit().setWidth(5)));

  static BorderRadius get all_8 => BorderRadius.all(Radius.circular(ZFit().setWidth(8)));

  static BorderRadius get all_10 => BorderRadius.all(Radius.circular(ZFit().setWidth(10)));

  static BorderRadius get all_15 => BorderRadius.all(Radius.circular(ZFit().setWidth(15)));

}