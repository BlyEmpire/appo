// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:google_mobile_ads/google_mobile_ads.dart';

// class AdBannerWidget extends StatefulWidget {
//   const AdBannerWidget({super.key, required this.adSize});

//   final AdSize adSize;

//   @override
//   State<AdBannerWidget> createState() => _AdBannerWidgetState();
// }

// class _AdBannerWidgetState extends State<AdBannerWidget> {
//   BannerAd? _bannerAd;
//   bool _isLoaded = false;
//   String _errorMessage = '';

//   @override
//   void initState() {
//     super.initState();
//     _loadBannerAd();
//   }

//   Future<void> _loadBannerAd() async {
//     try {
//       // Wait for MobileAds to be initialized
//       await MobileAds.instance.initialize();

//       _bannerAd = BannerAd(
//         size: widget.adSize,
//         adUnitId: _getAdUnitId(),
//         request: const AdRequest(),
//         listener: BannerAdListener(
//           onAdLoaded: (Ad ad) {
//             // print('Ad loaded successfully');
//             setState(() {
//               _isLoaded = true;
//               _bannerAd = ad as BannerAd?;
//             });
//           },
//           onAdFailedToLoad: (Ad ad, LoadAdError error) {
//             // print('Ad failed to load: $error');
//             ad.dispose();
//             setState(() {
//               _isLoaded = false;
//               _errorMessage = error.message;
//             });
//           },
//           // onAdOpened: (Ad ad) => print('Ad opened'),
//           // onAdClosed: (Ad ad) => print('Ad closed'),
//         ),
//       );

//       await _bannerAd!.load();
//     } catch (e) {
//       // print('Error loading ad: $e');
//       setState(() {
//         _errorMessage = e.toString();
//       });
//     }
//   }

//   String _getAdUnitId() {
//     // Test IDs for development
//     if (Platform.isAndroid) {
//       return 'ca-app-pub-3940256099942544/6300978111'; // Android test banner
//     } else if (Platform.isIOS) {
//       return 'ca-app-pub-3940256099942544/2934735716'; // iOS test banner
//     }
//     return ''; // For web or other platforms
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (!_isLoaded && _errorMessage.isEmpty) {
//       return SizedBox(
//         height: widget.adSize.height.toDouble(),
//         child: const Center(child: CircularProgressIndicator()),
//       );
//     }

//     if (_errorMessage.isNotEmpty) {
//       return SizedBox(
//         height: widget.adSize.height.toDouble(),
//         child: Center(
//           child: Text(
//             'Ad failed: $_errorMessage',
//             style: const TextStyle(color: Colors.red, fontSize: 12),
//           ),
//         ),
//       );
//     }

//     return SizedBox(
//       height: widget.adSize.height.toDouble(),
//       width: widget.adSize.width.toDouble(),
//       child: AdWidget(ad: _bannerAd!),
//     );
//   }

//   @override
//   void dispose() {
//     _bannerAd?.dispose();
//     super.dispose();
//   }
// }
