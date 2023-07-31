part of '../myspace_page.dart';


class DataChart{

  static LineChartData lineCharData() {
    return LineChartData(
      lineTouchData: const LineTouchData(
        enabled: true,

      ),
      gridData: const FlGridData(show: true,),
      titlesData: FlTitlesData(
        topTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true, // true,
            reservedSize: 60,
            interval: 1,
            //margin: 10,
            getTitlesWidget: (value, meta) {

              TextStyle style = const TextStyle(
                color: Color(0xff72719b),
                //fontWeight: FontWeight.bold,
                fontSize: 14,
              );

              String text = '';

              switch (value.toInt()) {
                case 2:
                  text = '1';
                  break;
                case 4:
                  text = '2';
                  break;
                case 6:
                  text = '3';
                  break;
                case 8:
                  text = '4';
                  break;
                case 10:
                  text = '5';
                  break;
                case 12:
                  text = '6';
                  break;
                default:
                  text = '';
                  break;
              }


              return Text(text,
                style: style,
              );

            },
          ),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 32,
            interval: 1,
            //margin: 10,
            getTitlesWidget: (value, meta) {

              TextStyle style = const  TextStyle(
                color: Color(0xffffffff),
                fontWeight: FontWeight.bold,
                fontSize: 16,
              );

              String text = "";

              switch (value.toInt()) {
                case 2:
                  text = 'LUN';
                  break;
                case 4:
                  text = 'MAR';
                  break;
                case 6:
                  text = 'MER';
                  break;
                case 8:
                  text = 'JEU';
                  break;
                case 10:
                  text = 'VEN';
                  break;
                case 12:
                  text = 'SAM';
                  break;
                default:
                  text = '';
                  break;
              }
              return SideTitleWidget(
                axisSide: meta.axisSide,
                space: 10,
                child: Text(text, style: style,),
              );
            },
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 1,
            reservedSize: 41,
            getTitlesWidget: (value, meta) {
              TextStyle style = const TextStyle(
                color: Color(0xff75729e),
                fontWeight: FontWeight.bold,
                fontSize: 14,
              );
              String text = "";
              switch (value.toInt()) {
                case 1:
                  text = '5k';
                  break;
                case 2:
                  text = '10k';
                  break;
                case 3:
                  text = '15k';
                  break;
                case 4:
                  text = '20k';
                  break;
                case 5:
                  text = '30k';
                  break;
                default:
                  return Container();


              }
              return Text(text, style: style, textAlign: TextAlign.center);
            },
          ),
        ),
      ),
      borderData: FlBorderData(
          show: true,
          border: const Border(
            bottom: BorderSide(
              color: Color(0xff4e4965),
              width: 4,
            ),
            left: BorderSide(
              color: Colors.transparent,
            ),
            right: BorderSide(
              color: Colors.transparent,
            ),
            top: BorderSide(
              color: Colors.transparent,
            ),
          ),
      ),
      minX: 0,
      maxX: 14,
      maxY: 5,
      minY: 0,
      lineBarsData: linesBarData,
    );
  }

  static List<LineChartBarData> get linesBarData {
    return [
      LineChartBarData(
        spots: const [ // reserved
          FlSpot(1, 0.1),
          FlSpot(3, 0.1),
          FlSpot(5, 1.5),
          FlSpot(7, 0.2),
          FlSpot(10, 0.3),
          FlSpot(12, 1.1),
          FlSpot(13, 0.8),
        ],
        isCurved: true,
        curveSmoothness: 0,
        color: const Color(0xffaaaf55),

        barWidth: 4,
        isStrokeCapRound: true,
        dotData: const FlDotData(
          show: false,
        ),
        belowBarData: BarAreaData(
          show: false,
        ),
      ),
      LineChartBarData(
        spots: const [
          FlSpot(1, 0.1),
          FlSpot(3, 2.0),
          FlSpot(7, 1.2),
          FlSpot(10, 2.8),
          FlSpot(12, 2.6),
          FlSpot(13, 3.9),
        ],
        isCurved: true,
        color: const
        Color(0x99aa4cfc),
        barWidth: 4,
        isStrokeCapRound: true,
        dotData: const FlDotData(
          show: false,
        ),
        belowBarData: BarAreaData(
          //show: true,
          color: const Color(0x33aa4cfc),

        ),
      ),
      LineChartBarData(
        spots: const [
          FlSpot(1, 2.8),
          FlSpot(3, 1.9),
          FlSpot(6, 3),
          FlSpot(10, 3.3),
          FlSpot(13, 4.5),
        ],
        isCurved: true,
        curveSmoothness: 0,
        color: const Color(0x4427b6fc),
        barWidth: 2,
        isStrokeCapRound: true,
        dotData: const FlDotData(show: true),
        belowBarData: BarAreaData(
          show: false,
        ),
      ),
    ];
  }

}

