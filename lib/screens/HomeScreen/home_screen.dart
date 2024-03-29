import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            // Scaffold.of(context).openDrawer();
          },
          icon: const Icon(Icons.menu, size: 30),
        ),
        title: const Text('Home'),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.search_outlined,
                size: 30,
              )),
          Stack(
            children: [
              IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.notifications_none_outlined,
                    size: 30,
                  )),
              Positioned(
                top: 2,
                right: 2,
                child: CircleAvatar(
                  backgroundColor: Colors.red.shade700,
                  foregroundColor: Colors.white,
                  radius: 10,
                  child: Center(
                      child: FittedBox(
                          child: const Text(
                    '5',
                  ))),
                ),
              ),
            ],
          )
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 16),
            color: Color(0xFF2f67de),
            child: EasyDateTimeLine(
              headerProps: const EasyHeaderProps(
                monthPickerType: MonthPickerType.switcher,
                monthStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
                showMonthPicker: true,
                showSelectedDate: false,
              ),
              initialDate: DateTime.now(),
              dayProps: EasyDayProps(
                  dayStructure: DayStructure.dayNumDayStr,
                  width: 80,
                  height: 80,
                  borderColor: Colors.transparent,
                  activeBorderRadius: 10,
                  activeDayDecoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  inactiveDayDecoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  activeDayNumStyle: const TextStyle(
                      color: Color(0xFF2f67de),
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                  activeDayStrStyle: const TextStyle(
                      color: Color(0xFF2f67de),
                      fontSize: 10,
                      fontWeight: FontWeight.w100),
                  inactiveDayNumStyle: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                  inactiveDayStrStyle: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.w100),
                  todayNumStyle: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                  todayStrStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.w100)),
            ),
          ),
          Container(
            color: Colors.white,
            padding: EdgeInsets.all(16),
            child: Row(
              children: [
                RichText(
                  text: TextSpan(style: TextStyle(fontSize: 18), children: [
                    TextSpan(
                        text: "Today Ticket ",
                        style: TextStyle(
                            color: Colors.grey, fontWeight: FontWeight.normal)),
                    TextSpan(
                        text: "(10)",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold))
                  ]),
                ),
                Spacer(),
                Text("Filter"),
                IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.filter_alt_outlined,
                      color: Color(
                        0xFF2f67de,
                      ),
                      size: 30,
                    ))
              ],
            ),
          ),
           Expanded(
             child: ListView.builder(
               padding: EdgeInsets.all(16),
               
               itemCount: 10,itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.symmetric(vertical: 8),
clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(10),

                  ),
                  child: Container(
                    margin: EdgeInsets.only(left: 5),
                    color: Colors.white,
                    padding: EdgeInsets.all(16),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text("#405514",style: TextStyle(fontSize: 12,color: Colors.grey,fontWeight: FontWeight.bold,),),
                                Text("Computer Not Working",style: TextStyle(fontSize: 12),)
                              ],
                            ),
                            Spacer(),
                            CircleAvatar(backgroundColor: Colors.grey.shade100,child: Icon(Icons.call,color: Colors.green,))
                          ],
                        ),
                        Divider(color: Colors.grey.shade200,thickness: 2,),
                        Row(
                          children: [
                            Text("Time : ",style: TextStyle(fontSize: 12,color: Colors.grey,fontWeight: FontWeight.w300,),),
                            Text("01:30 PM",style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold),),
                            Spacer(),
                            Text("Priority : ",style: TextStyle(fontSize: 12,color: Colors.grey,fontWeight: FontWeight.w300,),),
                            Text("High",style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold,color: Colors.deepPurple),),
                          ],
                        )
                        Row(
                          children: [
                            Icon(Icons.location_on_outlined)
                          ],
                        )
                      ],
                    ),
                  ),
                );
             },),
           )
        ],
      ),
    );
  }
}
