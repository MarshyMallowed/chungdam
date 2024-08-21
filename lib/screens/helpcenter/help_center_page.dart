import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'UpdateAccountPage.dart'; // Import the page for updating account info
import 'ForgotPasswordPage.dart'; // Import the Forgot Password page
import 'PaymentMethodsPage.dart'; // Import the Payment Methods page



class HelpCenterPage extends StatefulWidget {
  const HelpCenterPage({Key? key}) : super(key: key);

  @override
  _HelpCenterPageState createState() => _HelpCenterPageState();
}

class _HelpCenterPageState extends State<HelpCenterPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<int> _animation;
  String _animatedText = "";
  final List<String> _chars = 'Start typing your search'.split('');
  int _charIndex = 0;
  bool _showPlaceholder = true;

  @override
  void initState() {
    super.initState();
    _animatedText = '';
    _controller = AnimationController(
      duration: Duration(milliseconds: 150 * _chars.length),
      vsync: this,
    );

    _animation = IntTween(begin: 0, end: _chars.length).animate(_controller)
      ..addListener(() {
        setState(() {
          _charIndex = _animation.value;
          _animatedText = _chars.sublist(0, _charIndex).join('');
        });
      });

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Help Center', style: TextStyle(color: Colors.white)),
        backgroundColor: Color(0xFF0c2344),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Column(
        children: <Widget>[
          SizedBox(height: 30),
          RichText(
            text: TextSpan(
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Color(0xFFD4AF37),
              ),
              children: <TextSpan>[
                TextSpan(text: 'How can we '),
                TextSpan(
                  text: 'help',
                  style: TextStyle(color: Color(0xFF0c2344)),
                ),
                TextSpan(text: ' you?'),
              ],
            ),
          ),
          SizedBox(height: 10),
          Stack(
            alignment: Alignment.centerLeft,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SizedBox(
                  height: 40,
                  child: TextField(
                    onTap: () {
                      setState(() {
                        _showPlaceholder = false;
                        _controller.stop();
                      });
                    },
                    decoration: InputDecoration(
                      hintText: _showPlaceholder ? "" : 'Start typing your search',
                      prefixIcon: Icon(Icons.search, color: Color(0xFF0c2344)),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(color: Color(0xFF0c2344), width: 1),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(color: Color(0xFF0c2344), width: 2),
                      ),
                      filled: true,
                      fillColor: Color(0xFFFAF7E8),
                      contentPadding: EdgeInsets.symmetric(vertical: 8.0),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 60,
                child: Visibility(
                  visible: _showPlaceholder,
                  child: Text(
                    _animatedText,
                    style: TextStyle(color: Colors.black54, fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Opacity(
            opacity: 0.3,
            child: Center(
              child: Image.asset('assets/logo.png', width: 220, height: 220),
            ),
          ),
          SizedBox(height: 20),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Color(0xFF0c2344),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(55),
                  topRight: Radius.circular(55),
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SvgPicture.asset(
                      'assets/faq_icon.svg',
                      color: Colors.white,
                      width: 60,
                      height: 60,
                    ),
                    SizedBox(height: 8),
                    Text('FAQ', style: TextStyle(fontSize: 24, color: Colors.white)),
                    ListTile(
                      title: Text('Update account information', style: TextStyle(color: Colors.white)),
                      trailing: Icon(
                        Icons.chevron_right,
                        color: Colors.white,
                        size: 24,
                      ),
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => UpdateAccountPage(),
                          ),
                        );
                      },
                    ),
                    ListTile(
                      title: Text('Forgot my password', style: TextStyle(color: Colors.white)),
                      trailing: Icon(
                        Icons.chevron_right,
                        color: Colors.white,
                        size: 24,
                      ),
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => ForgotPasswordPage(),
                          ),
                        );
                      },
                    ),
                    ListTile(
                      title: Text('Available payment methods', style: TextStyle(color: Colors.white)),
                      trailing: Icon(
                        Icons.chevron_right,
                        color: Colors.white,
                        size: 24,
                      ),
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => PaymentMethodsPage(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
