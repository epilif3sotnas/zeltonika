module ut_coordinate_math


// internal
import internal.utils.coordinatemath as coordinate_math


fn test__convert_coordinate_to_teltonika_format__should_return_valid_teltonika_coordinate_format() {
  input_latitude := 51.50722;
  input_longitude := -0.1275;

  expected_latitude := 515072200;
  actual_latitude := coordinate_math.convert_coordinate_to_teltonika_format(input_latitude);

  assert expected_latitude == actual_latitude

  expected_longitude := -1275000;
  actual_longitude := coordinate_math.convert_coordinate_to_teltonika_format(input_longitude);

  assert expected_longitude == actual_longitude
}

fn test__convert_coordinate_to_teltonika_format__should_return_f64_value() {
  input_latitude := 515072200;
  input_longitude := -1275000;

  expected_latitude := 51.50722;
  actual_latitude := coordinate_math.convert_teltonika_format_to_float(input_latitude);

  assert expected_latitude == actual_latitude

  expected_longitude := -0.1275;
  actual_longitude := coordinate_math.convert_teltonika_format_to_float(input_longitude);

  assert expected_longitude == actual_longitude
}
