import 'package:flutter/material.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({Key? key}) : super(key: key);

  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  String _selectedAddress = 'Home'; // Default selected address
  String _selectedPaymentMethod = 'Cash on Delivery'; // Default selected payment method

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
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'Check Out',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
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
                  child: SizedBox(
                    width: 200, // Set the desired width here
                    child: ElevatedButton(
                      onPressed: () {
                        // Implement place order logic here
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFfff6cd),
                        minimumSize: const Size.fromHeight(45),
                        side: const BorderSide(color: Colors.black, width: 2), // Thick outline border
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(150.0), // Rounded edges
                        ),
                      ),
                      child: const Text(
                        'PLACE ORDER',
                        style: TextStyle(color: Colors.black, letterSpacing: 1.2), // Capitalized and black
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 50),
              ],
            ),
          ),
        ),
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
            style: TextStyle(
              fontSize: 16, // Set font size to 16
              fontWeight: FontWeight.bold, // Make text bold
            ),
          ),
          subtitle: Text(
            address,
            style: TextStyle(fontSize: 16), // Set font size to 16
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
      padding: const EdgeInsets.all(16.0), // Add padding inside the container
      decoration: BoxDecoration(
        color: const Color(0xFF0c2344), // Dark blue background color
        borderRadius: BorderRadius.circular(12.0),
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                _buildCustomRadio(value == _selectedPaymentMethod), // Custom radio button
                const SizedBox(width: 8.0),
                Text(
                  label,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16, // Text color white and font size 16
                    fontWeight: FontWeight.bold, // Make text bold
                  ),
                ),
              ],
            ),
            if (icons != null)
              Padding(
                padding: const EdgeInsets.only(left: 32.0, top: 8.0), // Indent the icons and add top spacing
                child: Row(
                  children: icons.map((iconPath) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: Image.asset(iconPath, width: 85), // Set width to 85 for slightly smaller images
                    );
                  }).toList(),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildCustomRadio(bool isSelected) {
    return Container(
      height: 20.0, // Reduced height
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
