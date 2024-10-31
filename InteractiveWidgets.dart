import 'package:flutter/material.dart';

void main() {
  runApp(SendMoneyApp());
}

class SendMoneyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Send Money',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: SendMoneyPage(),
    );
  }
}

class SendMoneyPage extends StatefulWidget {
  @override
  _SendMoneyPageState createState() => _SendMoneyPageState();
}

class _SendMoneyPageState extends State<SendMoneyPage> {
  final _formKey = GlobalKey<FormState>();
  String recipientName = '';
  double amount = 0.0;
  String? paymentMethod;
  bool isFavorite = false;

  // Sample payment methods
  final List<String> paymentMethods = ['Credit Card', 'Debit Card', 'PayPal'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Send Money')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Recipient Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a recipient name';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    recipientName = value;
                  });
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Amount'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || double.tryParse(value) == null || double.parse(value) <= 0) {
                    return 'Please enter a positive amount';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    amount = double.tryParse(value) ?? 0.0;
                  });
                },
              ),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(labelText: 'Payment Method'),
                value: paymentMethod,
                items: paymentMethods.map((method) {
                  return DropdownMenuItem<String>(
                    value: method,
                    child: Text(method),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    paymentMethod = value;
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return 'Please select a payment method';
                  }
                  return null;
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('Mark as Favorite'),
                  Switch(
                    value: isFavorite,
                    onChanged: (value) {
                      setState(() {
                        isFavorite = value;
                      });
                    },
                  ),
                ],
              ),
              SizedBox(height: 20),
              CustomButton(
                text: 'Send Money',
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Proceed with the transaction
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Transaction Successful!')),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const CustomButton({Key? key, required this.text, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(text),
      style: ElevatedButton.styleFrom(
        primary: Colors.blue, // Background color
        onPrimary: Colors.white, // Text color
        padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 30.0),
      ),
    );
  }
}
