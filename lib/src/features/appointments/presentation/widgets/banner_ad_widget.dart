// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:google_mobile_ads/google_mobile_ads.dart';

// class BannerAdWidget extends StatefulWidget {
//   final AdSize? adSize;
//   final bool showOnError;

//   const BannerAdWidget({super.key, this.adSize, this.showOnError = false});

//   @override
//   State<BannerAdWidget> createState() => _BannerAdWidgetState();
// }

// class _BannerAdWidgetState extends State<BannerAdWidget> {
//   BannerAd? _bannerAd;
//   bool _isLoaded = false;
//   bool _isError = false;
//   String? _errorMessage;

//   @override
//   void initState() {
//     super.initState();
//     _loadAd();
//   }

//   Future<void> _loadAd() async {
//     try {
//       // Use adaptive size if not specified
//       final adSize = widget.adSize ?? AdSize.banner;

//       _bannerAd = BannerAd(
//         adUnitId: _getAdUnitId(),
//         size: adSize,
//         request: _getAdRequest(),
//         listener: BannerAdListener(
//           onAdLoaded: (ad) {
//             debugPrint('Ad loaded successfully');
//             setState(() {
//               _isLoaded = true;
//               _isError = false;
//             });
//           },
//           onAdFailedToLoad: (ad, error) {
//             debugPrint('Ad failed to load: $error');
//             ad.dispose();
//             setState(() {
//               _isLoaded = false;
//               _isError = true;
//               _errorMessage = error.message;
//             });

//             // Optionally retry after delay
//             if (widget.showOnError) {
//               Future.delayed(const Duration(seconds: 30), _loadAd);
//             }
//           },
//           onAdOpened: (ad) => debugPrint('Ad opened'),
//           onAdClosed: (ad) => debugPrint('Ad closed'),
//           onAdImpression: (ad) => debugPrint('Ad impression recorded'),
//         ),
//       )..load();
//     } catch (e) {
//       debugPrint('Error creating banner ad: $e');
//       setState(() {
//         _isError = true;
//         _errorMessage = e.toString();
//       });
//     }
//   }

//   String _getAdUnitId() {
//     // Test IDs for development
//     const testAndroidId = 'ca-app-pub-3940256099942544/6300978111';
//     const testIOSId = 'ca-app-pub-3940256099942544/2934735716';

//     // TODO: Replace with your actual ad unit IDs for production
//     // const productionAndroidId = 'YOUR_ANDROID_AD_UNIT_ID';
//     // const productionIOSId = 'YOUR_IOS_AD_UNIT_ID';

//     if (Platform.isAndroid) {
//       return testAndroidId;
//     } else if (Platform.isIOS) {
//       return testIOSId;
//     }
//     return testAndroidId;
//   }

//   AdRequest _getAdRequest() {
//     return const AdRequest(
//       // Add test devices for development
//       // testDevices: ['YOUR_TEST_DEVICE_ID'],

//       // Add keywords if needed
//       // keywords: ['appointment', 'scheduling', 'calendar'],

//       // Set content targeting
//       contentUrl: 'https://yourapp.com',
//     );
//   }

//   @override
//   void dispose() {
//     _bannerAd?.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     // If ad is not loaded and we shouldn't show on error, return empty
//     if (!_isLoaded && !widget.showOnError) {
//       return const SizedBox.shrink();
//     }

//     // If error and we should show something, show error placeholder
//     if (_isError && widget.showOnError) {
//       return Container(
//         height:
//             _bannerAd?.size.height.toDouble() ??
//             AdSize.banner.height.toDouble(),
//         width: double.infinity,
//         color: Colors.grey[200],
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             const Icon(Icons.error_outline, color: Colors.grey),
//             const SizedBox(height: 4),
//             Text(
//               'Ad not available',
//               style: TextStyle(fontSize: 12, color: Colors.grey[600]),
//             ),
//           ],
//         ),
//       );
//     }

//     // Show ad if loaded
//     if (_isLoaded && _bannerAd != null) {
//       return Container(
//         height: _bannerAd!.size.height.toDouble(),
//         width: double.infinity,
//         alignment: Alignment.center,
//         child: AdWidget(ad: _bannerAd!),
//       );
//     }

//     // Show loading state
//     return Container(
//       height:
//           widget.adSize?.height.toDouble() ?? AdSize.banner.height.toDouble(),
//       width: double.infinity,
//       color: Colors.grey[100],
//       child: const Center(
//         child: SizedBox(
//           width: 20,
//           height: 20,
//           child: CircularProgressIndicator(strokeWidth: 2),
//         ),
//       ),
//     );
//   }
// }
