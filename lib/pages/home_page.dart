import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/cubits/weather_cubit/weather_cubit.dart';
import 'package:weather_app/cubits/weather_cubit/weather_state.dart';
import 'package:weather_app/models/custom_weather_default.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/models/custom_weather_success.dart';
import 'package:weather_app/pages/search_page.dart';

class HomePage extends StatelessWidget {
  WeatherModel? weatherData;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return SearchPage(
                    //updateUi: updateUi,
                    );
              }));
            },
            icon: const Icon(Icons.search),
          ),
        ],
        title: const Text('Weather App'),
      ),
      body: BlocBuilder<WeatherCubit, WeatherState>(
        builder: (context, state) {
          if (state is WeatherLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is WeatherSuccess) {
          // weatherData= BlocProvider.of<WeatherCubit>(context).wea;
            return CustomWeatherSuccess(weatherData: state.weatherModel);
          } else if (state is WeatherFailure) {
            return const Center(
              child: Text('Something went wrong! Please try again'),
            );
          } else {
            return const CustomWeatherDefault();
          }
        },
      ),
    );
  }
}
