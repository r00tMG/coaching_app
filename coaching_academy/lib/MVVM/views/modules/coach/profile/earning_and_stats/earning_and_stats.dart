import 'package:coaching_academy/MVVM/views/global/auth/helper/global_helper.dart';
import 'package:coaching_academy/utils/constants/images.dart';
import 'package:coaching_academy/utils/widgets/text/custom_text.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class EarningStatsScreen extends StatelessWidget {
  const EarningStatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Background is now white
      appBar: customAppBar(
          title: "Earning & Stats",
          onPress: () {
            Navigator.pop(context);
          }),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // Line chart container
            Expanded(
              flex: 3,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white, // Chart container background
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    // Dropdown for Day/Month/Year
                    Align(
                      alignment: Alignment.topRight,
                      child: Container(
                        decoration: const BoxDecoration(),
                        padding: const EdgeInsets.all(8.0),
                        child: DropdownButton<String>(
                          underline: const SizedBox(),
                          value: 'Day',
                          dropdownColor: Colors.white,
                          items: <String>['Day', 'Month', 'Year']
                              .map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: CustomText(
                                text: value,
                                style: const TextStyle(color: Colors.black),
                              ),
                            );
                          }).toList(),
                          onChanged: (newValue) {},
                        ),
                      ),
                    ),
                    // Actual colorful graph
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: LineChart(
                          LineChartData(
                            backgroundColor: Colors.transparent,
                            gridData: const FlGridData(show: true),
                            titlesData: FlTitlesData(
                              leftTitles: AxisTitles(
                                sideTitles: SideTitles(
                                  showTitles: true,
                                  getTitlesWidget: (value, meta) {
                                    return CustomText(
                                      text: '\$${value.toInt()}',
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 12,
                                      ),
                                    );
                                  },
                                  reservedSize: 40,
                                ),
                              ),
                              bottomTitles: AxisTitles(
                                sideTitles: SideTitles(
                                  showTitles: true,
                                  getTitlesWidget: (value, meta) {
                                    const months = [
                                      'Jan',
                                      'Feb',
                                      'Mar',
                                      'Apr',
                                      'May',
                                      'Jun'
                                    ];
                                    return CustomText(
                                      text: months[value.toInt()],
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 12,
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                            borderData: FlBorderData(
                              show: true,
                              border: Border.all(color: Colors.black38),
                            ),
                            minX: 0,
                            maxX: 5,
                            minY: 25,
                            maxY: 135,
                            lineBarsData: [
                              LineChartBarData(
                                spots: [
                                  const FlSpot(0, 50),
                                  const FlSpot(1, 100),
                                  const FlSpot(2, 75),
                                  const FlSpot(3, 120),
                                  const FlSpot(4, 85),
                                  const FlSpot(5, 110),
                                ],
                                isCurved: true,
                                // colors: [Colors.blue, Colors.purple],
                                gradient: const LinearGradient(
                                  colors: [Colors.blue, Colors.purple],
                                ),
                                barWidth: 3,
                                belowBarData: BarAreaData(
                                  show: true,
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.blue.withOpacity(0.4),
                                      Colors.purple.withOpacity(0.4)
                                    ],
                                  ),
                                ),
                                dotData: const FlDotData(
                                  show: true,
                                  // dotColor: Colors.orange,
                                  // dotSize: 4,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Stats cards
            Expanded(
              flex: 1,
              child: Row(
                children: [
                  // Total Bookings card
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const CustomText(
                            text: 'Total Bookings',
                            color: Colors.black,
                            fontSize: 16,
                          ),
                          const SizedBox(height: 10),
                          const CustomText(
                            text: '34',
                            color: Colors.black,
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                          SvgPicture.asset(
                            AppImages.myBooking,
                            // fit: BoxFit.scaleDown,
                            height: 50,
                            color: Colors.black,
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Total Earnings card
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const CustomText(
                            text: 'Total Earn',
                            color: Colors.black,
                            fontSize: 16,
                          ),
                          const SizedBox(height: 10),
                          const CustomText(
                            text: '1000\$',
                            color: Colors.black,
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              showWithdrawPopup(context);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: const CustomText(
                              text: "Withdraw",
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          )
                        ],
                      ),
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
}
