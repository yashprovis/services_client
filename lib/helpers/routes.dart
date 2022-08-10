import 'package:flutter/material.dart';
import 'package:services_client/screens/worker_list.dart';

import '../screens/forgot_password.dart';
import '../screens/login.dart';

import '../screens/profile/edit_profile.dart';
import '../screens/profile/help_support.dart';
import '../screens/profile/terms_conditions.dart';
import '../screens/register.dart';
import '../screens/tabs.dart';
import '../screens/worker_details.dart';

class RouteGenerator {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case TabsScreen.routeName:
        return MaterialPageRoute(
          builder: (context) => const TabsScreen(),
        );
      // case ProductListScreen.routeName:
      //   return MaterialPageRoute(
      //     builder: (context) => ProductListScreen(args: args as Map),
      //   );
      // case ProductDetailScreen.routeName:
      //   return MaterialPageRoute(
      //     builder: (context) => ProductDetailScreen(productId: args as String),
      //   );
      case LoginScreen.routeName:
        return MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        );
      case RegisterScreen.routeName:
        return MaterialPageRoute(
          builder: (context) => const RegisterScreen(),
        );
      case ForgotPasswordScreen.routeName:
        return MaterialPageRoute(
          builder: (context) => const ForgotPasswordScreen(),
        );

      case EditProfile.routeName:
        return MaterialPageRoute(
          builder: (context) => const EditProfile(),
        );
      case TermsConditions.routeName:
        return MaterialPageRoute(
          builder: (context) => TermsConditions(),
        );
      case HelpSupport.routeName:
        return MaterialPageRoute(
          builder: (context) => HelpSupport(),
        );
      case WorkerList.routeName:
        return MaterialPageRoute(
          builder: (context) => WorkerList(caetgoryId: args as String),
        );
      case WorkerDetails.routeName:
        return MaterialPageRoute(
          builder: (context) => WorkerDetails(workerId: args as String),
        );
      // case SearchScreen.routeName:
      //   return MaterialPageRoute(
      //     builder: (context) => SearchScreen(),
      //   );
      default:
        return errorRoute();
    }
  }

  static Route<dynamic> errorRoute() {
    return MaterialPageRoute(
      builder: (context) {
        return Scaffold(
          appBar: AppBar(title: const Text('ERROR')),
          body: const Center(
            child: Text("Page not found"),
          ),
        );
      },
    );
  }
}
