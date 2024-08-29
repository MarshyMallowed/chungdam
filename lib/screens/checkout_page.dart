import 'package:flutter/material.dart';
import 'package:chungdam/screens/order_status_page.dart';
class CheckoutPage extends StatefulWidget {
  const CheckoutPage({Key? key}) : super(key: key);

  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  String _selectedAddress = 'Home'; // Default selected address
  String _selectedPaymentMethod = 'Cash on Delivery'; // Default selected payment method
  bool _isOrderPlaced = false; // Track if the order is placed to toggle transparency

  // Dummy addresses for the example
  String _homeAddress = 'Street, District, Barangay, City, Region, Postal Code';
  String _officeAddress = 'Street, District, Barangay, City, Region, Postal Code';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF0c2344), // Dark blue color
        iconTheme: const IconThemeData(color: Colors.white), // Set the icon color to white
        leading: IconButton(
          icon: const Icon(Icons.arrow_back), // Use the arrow back icon
          onPressed: () => Navigator.pop(context),
          color: Colors.white, // Set the arrow back button color to white
        ),
      ),
      backgroundColor: const Color(0xFFFAF7E8), // Light background color
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                Container(
                  color: const Color(0xFFFAF7E8), // Same background color as page
                  padding: const EdgeInsets.all(16.0),
                  alignment: Alignment.center,
                  child: const Text(
                    'Check Out',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0), // Reduced outer padding to increase width
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // The checkout list
                          Container(
                            padding: const EdgeInsets.all(16.0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.black),
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // TITLE row with dark blue background
                                Container(
                                  color: const Color(0xFF0c2344), // Dark blue background color
                                  padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                                  child: Row(
                                    children: const [
                                      Expanded(
                                        flex: 5,
                                        child: Text(
                                          ' TITLE',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white, // White text color
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Text(
                                          'ITEM(S)',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white, // White text color
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 3,
                                        child: Text(
                                          'PRICE ',
                                          textAlign: TextAlign.right,
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white, // White text color
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const Divider(color: Colors.black),
                                _buildCheckoutItem('HANWOO PRIME RIBEYE\n150g', 'x1', 'P 2800.00'),
                                _buildCheckoutItem('HANWOO OUTSIDE SKIRT MEAT\n100g', 'x1', 'P 2500.00'),
                                _buildCheckoutItem('HANWOO TENDERLOIN\n150g', 'x1', 'P 2800.00'),
                                const Divider(color: Colors.black),
                                _buildTotalRow('Subtotal', 'P 8100.00', withBackground: true, backgroundColor: const Color(0xFFffeead)),
                                _buildTotalRow('Shipping', 'P 100.00', withBackground: true, backgroundColor: const Color(0xFFffeead)),
                                _buildTotalRow('Discount', 'P 0.00', withBackground: true, backgroundColor: const Color(0xFFffeead)),
                                const Divider(color: Colors.black),
                                _buildTotalRow('TOTAL', 'P 8200.00', isBold: true, withBackground: true, backgroundColor: const Color(0xFFeeeeee)),
                              ],
                            ),
                          ),
                          const SizedBox(height: 24),
                          const Text(
                            'Address',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 18),
                          _buildAddressOption(context, 'Home', _homeAddress, 'Home'),
                          const SizedBox(height: 8),
                          _buildAddressOption(context, 'Office', _officeAddress, 'Office'),
                          const SizedBox(height: 24),
                          const Text(
                            'Payment',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 18),
                          _buildPaymentOptionsContainer(context),
                          const SizedBox(height: 35),
                          Center(
                            child: Column(
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      _isOrderPlaced = true; // Set transparency when placing order
                                    });
                                    _showOrderConfirmationDialog(context);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFFffeead), // Updated background color for the button
                                    padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 50.0),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30.0),
                                    ),
                                    side: BorderSide(color: Colors.black, width: 2.0),
                                  ),
                                  child: const Text(
                                    'PLACE ORDER',
                                    style: TextStyle(color: Colors.black, letterSpacing: 1.2, fontWeight: FontWeight.bold, fontSize: 16),
                                  ),
                                ),
                                const SizedBox(height: 20), // Add space below the button
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            // Only show the dark transparent overlay if the order is placed
            if (_isOrderPlaced)
              Positioned.fill(
                child: AnimatedOpacity(
                  opacity: _isOrderPlaced ? 0.5 : 0.0, // Slightly lighter background
                  duration: const Duration(milliseconds: 400),
                  child: Container(
                    color: Colors.black,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  void _showOrderConfirmationDialog(BuildContext context) {
    final double buttonWidth = MediaQuery.of(context).size.width * 0.58; // Adjusted width for both buttons
    final String id = 'RVD-001-03-083124-000000';
    final String customerId = id.substring(id.length - 6, id.length );
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.white, // Solid white background for the dialog
          insetPadding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 130.0), // Reduced padding to increase dialog width
          child: Center(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white, // Solid white background
                borderRadius: BorderRadius.circular(12.0),
              ),
              padding: const EdgeInsets.all(8.0), // Further reduced padding
              child: Column(
                mainAxisSize: MainAxisSize.min, // Wrap content height
                children: [
                  Image.asset('assets/order_confirmed.png', height: 250), // Larger image
                  const SizedBox(height: 8), // Further reduced spacing
                  const Text(
                    'YOUR ORDER IS CONFIRMED!',
                    style: TextStyle(
                      fontSize: 18, // Reduced font size
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 4), // Further reduced spacing
                  Text(
                    'Your order #$customerId is successfully placed',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 12), // Further reduced spacing
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context, 
                        MaterialPageRoute(builder:(context) => OrderStatusPage(transactionId : id))
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF0c2344),
                      padding: const EdgeInsets.symmetric(vertical: 14.0), // Further reduced height
                      minimumSize: Size(buttonWidth, 0), // Set minimum width
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0), // Match shape to place order button
                      ),
                    ),
                    child: const Text(
                      'TRACK ORDER',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8), // Further reduced spacing
                  OutlinedButton(
                    onPressed: () {
                      Navigator.pop(context); // Close the dialog
                      setState(() {
                        _isOrderPlaced = false; // Reset transparency when dialog is closed
                      });
                    },
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14.0), // Further reduced height
                      minimumSize: Size(buttonWidth, 0), // Set minimum width
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0), // Match shape to place order button
                      ),
                      side: const BorderSide(color: Color(0xFFbc9c22), width: 2.0), // Updated border color
                    ),
                    child: const Text(
                      'GO BACK',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildCheckoutItem(String title, String quantity, String unitPrice) {
    return Container(
      color: const Color(0xFFeeeeee), // Light grey background color
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 12.0), // Increased horizontal padding
      child: Row(
        children: [
          Expanded(
            flex: 5,
            child: Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.normal,
                overflow: TextOverflow.visible, // Ensure the text doesn't wrap
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              quantity,
              textAlign: TextAlign.center,
              style: const TextStyle(
                overflow: TextOverflow.visible, // Ensure the text doesn't wrap
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              unitPrice,
              textAlign: TextAlign.right,
              style: const TextStyle(
                overflow: TextOverflow.visible, // Ensure the text doesn't wrap
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTotalRow(String label, String value, {bool isBold = false, bool withBackground = false, Color backgroundColor = Colors.transparent}) {
    return Container(
      color: withBackground ? backgroundColor : Colors.transparent, // Apply background color if needed
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 12.0), // Increased horizontal padding
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              fontSize: 14, // Consistent font size for all
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              fontSize: 14, // Consistent font size for all
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddressOption(BuildContext context, String label, String address, String value) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedAddress = value; // Update selected address
        });
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: _selectedAddress == value ? const Color(0xFF0c2344) : Colors.grey),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: ListTile(
          leading: Radio<String>(
            value: value,
            groupValue: _selectedAddress,
            onChanged: (String? newValue) {
              setState(() {
                _selectedAddress = newValue!;
              });
            },
            activeColor: const Color(0xFF0c2344),
          ),
          title: Text(
            label,
            style: const TextStyle(
              fontSize: 16, // Set font size to 16
              fontWeight: FontWeight.bold, // Make text bold
            ),
          ),
          subtitle: Text(
            address,
            style: const TextStyle(
              fontSize: 14, // Set font size to match Subtotal, Shipping, and Discount
              fontWeight: FontWeight.normal,
            ),
          ),
          trailing: IconButton(
            icon: const Icon(Icons.edit, color: Colors.grey),
            onPressed: () {
              _showEditAddressDialog(context, label == 'Home' ? _homeAddress : _officeAddress, (newAddress) {
                setState(() {
                  if (label == 'Home') {
                    _homeAddress = newAddress;
                  } else if (label == 'Office') {
                    _officeAddress = newAddress;
                  }
                });
              });
            },
          ),
        ),
      ),
    );
  }

  void _showEditAddressDialog(BuildContext context, String currentAddress, Function(String) onSave) {
    final TextEditingController _controller = TextEditingController(text: currentAddress);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Edit Address'),
          content: TextField(
            controller: _controller,
            decoration: const InputDecoration(
              hintText: 'Enter new address',
            ),
            maxLines: 3,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                onSave(_controller.text);
                Navigator.of(context).pop();
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildPaymentOptionsContainer(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0), // Increased padding inside the container
      decoration: BoxDecoration(
        color: const Color(0xFF0c2344), // Dark blue background color
        borderRadius: BorderRadius.circular(14.0), // Slightly increased border radius
      ),
      child: Column(
        children: [
          _buildPaymentOption(context, 'Card', ['assets/visa.png', 'assets/mastercard.png', 'assets/paypal.png'], 'Card'),
          const SizedBox(height: 12.0), // Add space between payment options
          _buildPaymentOption(context, 'Cash on Delivery', null, 'Cash on Delivery'),
          const SizedBox(height: 12.0), // Add space between payment options
          _buildPaymentOption(context, 'GCash', null, 'GCash'),
          const SizedBox(height: 12.0), // Add space between payment options
          _buildPaymentOption(context, 'PayMaya', null, 'PayMaya'),
        ],
      ),
    );
  }

  Widget _buildPaymentOption(BuildContext context, String label, List<String>? icons, String value) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedPaymentMethod = value; // Update selected payment method
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0), // Add margin between options
        child: Row(
          children: [
            const SizedBox(width: 16.0), // Move the radio button to the right
            Transform.translate(
              offset: label == 'Card' ? const Offset(0, -23) : Offset.zero, // Move the circle up slightly for the 'Card' option
              child: _buildCustomRadio(value == _selectedPaymentMethod), // Custom radio button
            ),
            const SizedBox(width: 22.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16, // Text color white and font size 16
                      fontWeight: FontWeight.bold, // Make text bold
                    ),
                  ),
                  if (icons != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0), // Add top spacing for icons
                      child: Row(
                        children: icons.map((iconPath) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4.0),
                            child: Image.asset(iconPath, width: 80), // Increased width to 70 for larger images
                          );
                        }).toList(),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCustomRadio(bool isSelected) {
    return Container(
      height: 30.0, // Reduced height
      width: 20.0,  // Reduced width
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.white,
          width: 2.0,
        ),
        color: isSelected ? Colors.white : Colors.transparent,
      ),
      child: isSelected
          ? const Center(
        child: Icon(
          Icons.check,
          color: Colors.black,
          size: 14.0, // Adjusted size to fit the smaller circle
        ),
      )
          : null,
    );
  }
}
