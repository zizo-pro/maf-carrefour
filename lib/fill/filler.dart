import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:maf_carrefour/models/products_model.dart';

class DioHelper {
  static Dio? dio;

  static init() {
    dio = Dio(BaseOptions(
      baseUrl: 'https://dummyjson.com/auth/login',
      receiveDataWhenStatusError: true,
    ));
  }

  static Future<Response> getData() async {
    dio!.options.headers = {'Content-Type': 'application/json', 'lang': 'en'};

    return await dio!.get('https://dummyjson.com/products?limit=100000000'
        // url,
        // queryParameters: query,
        );
  }

  static Future<Response> postData(
      {required String url,
      Map<String, dynamic>? query,
      required Map<String, dynamic> data,
      String lang = 'en',
      String? token}) async {
    dio!.options.headers = {
      'Content-Type': 'application/json',
      'lang': lang,
      'Authorization': token
    };
    return dio!.post(
      url,
      queryParameters: query,
      data: data,
    );
  }

  static Future<Response> putData(
      {required String url,
      Map<String, dynamic>? query,
      required Map<String, dynamic> data,
      String lang = 'en',
      String? token}) async {
    dio!.options.headers = {
      'Content-Type': 'application/json',
      'lang': lang,
      'Authorization': token
    };
    return dio!.put(
      url,
      queryParameters: query,
      data: data,
    );
  }
}

void master() async {
  await DioHelper.init();
  List<dynamic> myitems = [];
  DioHelper.getData().then((value) {
    myitems.add(value.data['products']);
    myitems[0].forEach((element) {
      // print(element);
      // print(element["title"]);
      // print("${element["price"]}");
      // print(element["rating"]);
      // print(element["stock"]);
      // print(element["category"]);
      // print(element["description"]);
      // print(element["id"]);
      ProductModel model = ProductModel(
        image: 'https://firebasestorage.googleapis.com/v0/b/maf-carrefour-c49d8.appspot.com/o/products%2F554432521.jpg?alt=media&token=b60feb72-c666-4a77-9d97-49cb9eaf1ad3',
        name: element["title"],
        price: "${element["price"]}",
        serial: "${element["id"]}",
        stock: "${element["stock"]}",
        discount: "${element['discountPercentage']}",
        rating: "${element['rating']}",
        description: element['description'],
        category: element['category'],
        brand: element['brand'],
      );
      FirebaseFirestore.instance
          .collection('products')
          .doc("${element["id"]}")
          .set(model.toMap())
          .then((value) => null)
          .catchError((error) {
        print(error);
      });
    });
  });
}
