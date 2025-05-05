import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:keno_plus/features/authentication/presentation/screens/sign_up.dart';

final GoRouter router = GoRouter(
  initialLocation: '/',
  routes: [
    // Sign Up route
    GoRoute(
      path: '/',
      name: 'signUp',
      builder: (context, state) => SignUpScreen(),
    ),

    // Home route with nested routes
    GoRoute(
      path: '/home',
      name: 'home',
      builder:
          (context, state) => Scaffold(
            appBar: AppBar(title: const Text('Home')),
            body: Center(child: const Text('Home Screen')),
          ),
      routes: [
        // nested routes
      ],
    ),
  ],
);
