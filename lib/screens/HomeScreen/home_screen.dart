import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
                  child: const Center(
                      child: FittedBox(
                          child: Text(
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
            color: Theme.of(context).primaryColor,
            child: EasyDateTimeLine(
              headerProps: const EasyHeaderProps(
                selectedDateFormat: SelectedDateFormat.fullDateDMonthAsStrY,
                selectedDateStyle: TextStyle(
                  color: Colors.white
                ),
                monthPickerType: MonthPickerType.switcher,
                monthStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
                showMonthPicker: true,
                showSelectedDate: true,
              ),
              initialDate: DateTime.now(),
              dayProps: EasyDayProps(
                  dayStructure: DayStructure.dayNumDayStr,
                  width: 60,
                  height: 60,
                  borderColor: Colors.transparent,
                  activeBorderRadius: 8,
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
                      fontSize: 14,
                      fontWeight: FontWeight.bold),
                  activeDayStrStyle: const TextStyle(
                      color: Color(0xFF2f67de),
                      fontSize: 8,
                      fontWeight: FontWeight.w100),
                  inactiveDayNumStyle: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold),
                  inactiveDayStrStyle: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.w100),
                  todayNumStyle: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold),
                  todayStrStyle: const TextStyle(
                      color: Colors.white,
                      fontSize: 8,
                      fontWeight: FontWeight.w100)),
            ),
          ),
          Container(
            color: Colors.white,
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    left: 16,
                  ),
                  child: RichText(
                    text: TextSpan(style: TextStyle(fontSize: 18), children: [
                      TextSpan(
                          text: "Today Ticket ",
                          style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.normal)),
                      TextSpan(
                          text: "(10)",
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold))
                    ]),
                  ),
                ),
                const Spacer(),
                InkWell(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return Container(
                          clipBehavior: Clip.hardEdge,
                          decoration: const BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10))),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                padding: EdgeInsets.all(16),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text("Filter"),
                                    IconButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        icon: Icon(
                                          Icons.close,
                                          color: Theme.of(context).primaryColor,
                                        ))
                                  ],
                                ),
                              ),
                              Container(
                                width: Get.width,
                                color: Colors.white,
                                padding: EdgeInsets.all(16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Status"),
                                    Wrap(
                                      alignment: WrapAlignment.spaceBetween,
                                      direction: Axis.horizontal,
                                      children: [
                                        Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Radio(
                                              value: true,
                                              groupValue: true,
                                              onChanged: (value) {},
                                            ),
                                            Text("All")
                                          ],
                                        ),
                                        Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Radio(
                                              value: true,
                                              groupValue: true,
                                              onChanged: (value) {},
                                            ),
                                            Text("Open")
                                          ],
                                        ),
                                        Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Radio(
                                              value: true,
                                              groupValue: true,
                                              onChanged: (value) {},
                                            ),
                                            Text("Close")
                                          ],
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 2,
                              ),
                              Container(
                                 width: Get.width,
                                color: Colors.white,
                                padding: EdgeInsets.all(16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Status"),
                                    Wrap(
                                      alignment: WrapAlignment.spaceBetween,
                                      spacing: 8.0, // Adjust spacing as needed
                                      children: [
                                        Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Radio(
                                              value: true,
                                              groupValue: true,
                                              onChanged: (value) {},
                                            ),
                                            Text("All")
                                          ],
                                        ),
                                        Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Radio(
                                              value: true,
                                              groupValue: true,
                                              onChanged: (value) {},
                                            ),
                                            Text("High")
                                          ],
                                        ),
                                        Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Radio(
                                              value: true,
                                              groupValue: true,
                                              onChanged: (value) {},
                                            ),
                                            Text("Medium")
                                          ],
                                        ),
                                        Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Radio(
                                              value: true,
                                              groupValue: true,
                                              onChanged: (value) {},
                                            ),
                                            Text("Low")
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 16,),
                                    ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          
                                        ),

                                        onPressed: () {

                                    }, child: Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text("Apply"),
                                        ],
                                      ),
                                    ))
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    color: Colors.blue,
                    child: Row(
                      children: [
                        Text("Filter"),
                        Icon(
                          Icons.filter_alt_outlined,
                          color: Color(
                            0xFF2f67de,
                          ),
                          size: 30,
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(16),
              itemCount: 10,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.symmetric(vertical: 8),
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Container(
                    margin: const EdgeInsets.only(left: 8),
                    color: Colors.white,
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          children: [
                            const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "#405514",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "Computer Not Working",
                                  style: TextStyle(fontSize: 12),
                                )
                              ],
                            ),
                            Spacer(),
                            CircleAvatar(
                                backgroundColor: Colors.grey.shade100,
                                child: Icon(
                                  Icons.call,
                                  color: Colors.green,
                                ))
                          ],
                        ),
                        Divider(
                          color: Colors.grey.shade200,
                          thickness: 2,
                        ),
                        Row(
                          children: [
                            Text(
                              "Time : ",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                            Text(
                              "01:30 PM",
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.bold),
                            ),
                            Spacer(),
                            Text(
                              "Priority : ",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                            Text(
                              "High",
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.deepPurple),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Row(
                          children: [
                            Icon(Icons.location_on_outlined),
                            Expanded(
                                child: Text(
                              "Gitschiner Str., Berlin Germany",
                              style: TextStyle(
                                fontSize: 12,
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ))
                          ],
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
