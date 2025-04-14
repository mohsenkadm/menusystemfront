

import 'package:menusystemfront/data/response/status.dart';

class ApiResponse<T> {

  Status? success ;
  T? data ;
  String? msg ;

  ApiResponse(this.success, this.data, this.msg) ;

  ApiResponse.loading() : success = Status.LOADING  ;
  ApiResponse.completed(this.data) : success = Status.COMPLETED  ;
  ApiResponse.error(this.msg) : success = Status.ERROR  ;


  @override
  String toString(){
    return "Status : $success \n Message :  $msg \n Data: $data" ;
  }
}