import 'package:animated_search_bar/animated_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jackpot_arena/Providers/bankInfoProvider.dart';
import 'package:jackpot_arena/Screens/Profile_Screen/Transaction/transactionDetails.dart';
import 'package:jackpot_arena/Widgets/bankDetailsWidget.dart';
import 'package:provider/provider.dart';

class Banksdetails extends StatefulWidget {
  TextEditingController searchController = TextEditingController();
  List<String> filteredName = [];
  List<String> filteredLogo = [];

  Banksdetails({super.key});

  @override
  State<Banksdetails> createState() => _BanksdetailsState();
}

class _BanksdetailsState extends State<Banksdetails> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var bankInfoProvider = Provider.of<Bankinfoprovider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 8,
              top: 16,
            ),
            child: AnimatedSearchBar(
              //height: 40,
              label: 'Banks and Wallets',
              //labelAlignment: Alignment.topLeft,
              labelTextAlign: TextAlign.start,
              labelStyle: GoogleFonts.poppins(
                fontSize: 18,
                color: Colors.black,
              ),
              controller: widget.searchController,
              onChanged: (p0) => bankInfoProvider.searchBankAccounts(p0),
              cursorColor: Colors.black26,
              searchDecoration: InputDecoration(
                label: Text('Search'),
                labelStyle: GoogleFonts.poppins(
                  fontSize: 16,
                  color: Colors.black26,
                ),
                floatingLabelAlignment: FloatingLabelAlignment.start,
                floatingLabelBehavior: FloatingLabelBehavior.never,
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(
                      30,
                    ),
                  ),
                  borderSide: BorderSide(
                    color: Color(0xffEFCC4E),
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(
                      30,
                    ),
                  ),
                  borderSide: BorderSide(
                    color: Color(0xffEFCC4E),
                  ),
                ),
              ),
            ),
          ),
          bankInfoProvider.bankLogo.length != bankInfoProvider.bankName.length
              ? CircularProgressIndicator(
                  color: Color(
                    0xffEFCC4E,
                  ),
                )
              : Expanded(
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: bankInfoProvider.bankName.length,
                    itemBuilder: (context, index) => GestureDetector(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Transactiondetails(
                            bankName: bankInfoProvider.bankName[index],
                            bankIcon: bankInfoProvider.bankLogo[index],
                          ),
                        ),
                      ),
                      child: Bankdetailswidget(
                        widgetContext: bankInfoProvider.bankName[index],
                        widgetImage: bankInfoProvider.bankLogo[index],
                      ),
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
