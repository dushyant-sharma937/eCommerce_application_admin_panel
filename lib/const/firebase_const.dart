import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

FirebaseAuth auth = FirebaseAuth.instance;
FirebaseFirestore firestore = FirebaseFirestore.instance;
User? currentUser = auth.currentUser;

// collections
const vendorCollections = "vendors";
const chatCollections = "chats";
const ordersCollection = "orders";
const productsCollection = "products";
