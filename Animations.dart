class _SendMoneyPageState extends State<SendMoneyPage> {
  // Other state variables...
  bool _showSuccessMessage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ...
      body: Padding(
        // ...
        child: Column(
          // ...
          children: [
            // Existing widgets...
            CustomButton(
              text: 'Send Money',
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  // Show success message
                  setState(() {
                    _showSuccessMessage = true;
                  });
                  // Hide the success message after 2 seconds
                  Future.delayed(Duration(seconds: 2), () {
                    setState(() {
                      _showSuccessMessage = false;
                    });
                  });
                }
              },
            ),
            AnimatedOpacity(
              opacity: _showSuccessMessage ? 1.0 : 0.0,
              duration: Duration(seconds: 1),
              child: Text(
                'Transaction Successful!',
                style: TextStyle(fontSize: 20, color: Colors.green),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
