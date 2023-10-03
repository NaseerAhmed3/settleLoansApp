import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:booking_calendar/booking_calendar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:settle_loans/Constrains/colors.dart';
import 'package:settle_loans/Constrains/textstyles.dart';

class ScheduleACall extends StatefulWidget {
  const ScheduleACall({Key? key}) : super(key: key);

  @override
  State<ScheduleACall> createState() => _ScheduleACallState();
}

class _ScheduleACallState extends State<ScheduleACall> {
  final now = DateTime.now();
  BookingService? callServiceBooking;

  @override
  void initState() {
    super.initState();

    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      FirebaseFirestore.instance
          .collection('userDetails')
          .doc(user.uid)
          .get()
          .then((doc) {
        if (doc.data() != null) {
          Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
          callServiceBooking = BookingService(
              serviceName: 'Call Service',
              serviceDuration: 30,
              userId: user.uid,
              userEmail: user.email,
              userPhoneNumber: data["phoneNumber"],
              userName: data["name"].toString(),
              bookingEnd: DateTime(now.year, now.month, now.day, 18, 0),
              bookingStart: DateTime(now.year, now.month, now.day, 8, 0));
        }
        setState(() {});
      });
    }
  }

  Stream<dynamic>? getBookingStreamMock(
      {required DateTime end, required DateTime start}) {
    return FirebaseFirestore.instance.collection("callBookings").snapshots();
  }

  Future<dynamic> uploadBookingMock(
      {required BookingService newBooking}) async {
    await Future.delayed(const Duration(seconds: 1));
    FirebaseFirestore.instance
        .collection('callBookings')
        .add(newBooking.toJson());
    converted.add(DateTimeRange(
        start: newBooking.bookingStart, end: newBooking.bookingEnd));
  }

  List<DateTimeRange> converted = [];

  List<DateTimeRange> convertStreamResultMock({required dynamic streamResult}) {
    ///here you can parse the streamresult and convert to [List<DateTimeRange>]
    ///take care this is only mock, so if you add today as disabledDays it will still be visible on the first load
    ///disabledDays will properly work with real data
    // DateTime first = now;
    // DateTime tomorrow = now.add(const Duration(days: 1));
    // DateTime second = now.add(const Duration(minutes: 55));
    // DateTime third = now.subtract(const Duration(minutes: 240));
    // DateTime fourth = now.subtract(const Duration(minutes: 500));
    // converted.add(
    //     DateTimeRange(start: first, end: now.add(const Duration(minutes: 30))));
    // converted.add(DateTimeRange(
    //     start: second, end: second.add(const Duration(minutes: 23))));
    // converted.add(DateTimeRange(
    //     start: third, end: third.add(const Duration(minutes: 15))));
    // converted.add(DateTimeRange(
    //     start: fourth, end: fourth.add(const Duration(minutes: 50))));

    // //book whole day example
    // converted.add(DateTimeRange(
    //     start: DateTime(tomorrow.year, tomorrow.month, tomorrow.day, 5, 0),
    //     end: DateTime(tomorrow.year, tomorrow.month, tomorrow.day, 23, 0)));
    List<DateTimeRange> converted = [];
    for (var i = 0; i < streamResult.size; i++) {
      Map<String, dynamic> item =
          streamResult.docs[i].data() as Map<String, dynamic>;
      converted.add(DateTimeRange(
          start: (DateTime.parse(item["bookingStart"])),
          end: (DateTime.parse(item["bookingEnd"]))));
    }
    return converted;
  }

  List<DateTimeRange> generatePauseSlots() {
    return [
      DateTimeRange(
          start: DateTime(now.year, now.month, now.day, 12, 0),
          end: DateTime(now.year, now.month, now.day, 13, 0))
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color.fromRGBO(99,99,99,1.000),
toolbarHeight: 150,
flexibleSpace:Column(

  mainAxisAlignment: MainAxisAlignment.center,
            children: [
             Padding(
               padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
               child: Row(
                
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
                 Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                      IconButton(onPressed: (){
                    Navigator.pop(context);
                   }, icon: Icon(Icons.arrow_back, size: 30.0,color: Colors.white,)),
                    Column(
                      
                      
  crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                  'Schedule a Call' ,style: HeadingTextStyle3(),
               
                ),
                // SizedBox(
                //   width: 10,
                // ),
             
                         Text(
                'Select date and time' ,style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                   fontWeight: FontWeight.w500,
                   
                      fontFamily: GoogleFonts.rubik().fontFamily,


                ) ,
               
              ),
                      ],
                    ),
                 
                  ],
                 ),
                   Icon(Icons.notifications, size: 30.0,color: Colors.white,),
                 ],
             ),)
           
             
    
             
            ],
          ),
      ),





      
      body: callServiceBooking != null
          ? Center(
              child: BookingCalendar(
                bookingButtonColor: Yellow,
                bookingButtonText: 'Confirm Booking',
                bookedSlotTextStyle: LabelTextStyle1(),
                availableSlotColor: Color.fromARGB(255, 248, 235, 190),
                bookedSlotColor: Color.fromARGB(255, 248, 235, 190),
                selectedSlotColor: Yellow,
                bookingService: callServiceBooking!,
                convertStreamResultToDateTimeRanges: convertStreamResultMock,
                getBookingStream: getBookingStreamMock,
                uploadBooking: uploadBookingMock,
                loadingWidget: const Text('Fetching data...'),
                uploadingWidget: const CircularProgressIndicator(),
                locale: 'en_EN',
                startingDayOfWeek: StartingDayOfWeek.monday,

                wholeDayIsBookedWidget:
                    const Text('Sorry, for this day everything is booked'),
                //disabledDates: [DateTime(2023, 1, 20)],
                disabledDays: const [6, 7],
              ),
            )
          : const SizedBox(),
    );
  }
}
