import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:trust_edge_task/app/core/api/api_consumer.dart';
import 'package:trust_edge_task/app/data/data_sources/local_data_sources/user_local_storage.dart';
import 'package:trust_edge_task/app/data/data_sources/remote_data_sources/auth_remote_data_source.dart';
import 'package:trust_edge_task/app/data/data_sources/remote_data_sources/user_remote_data_source.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(const FlutterSecureStorage());

    Get.lazyPut<ApiConsumer>(
      () => ApiConsumerImpl(),
      fenix: true,
    );

    Get.lazyPut<UserLocalStorage>(
      () => UserLocalStorageImp(
        storage: Get.find(),
      ),
      fenix: true,
    );

    Get.lazyPut<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImp(
        apiConsumer: Get.find(),
      ),
      fenix: true,
    );

    Get.lazyPut<UserRemoteDataSource>(
      () => UserRemoteDataSourceImp(
        apiConsumer: Get.find(),
      ),
      fenix: true,
    );
  }

  static attachTokenToDio(String token) {
    Get.find<ApiConsumer>().attachToken(token);
  }
}
