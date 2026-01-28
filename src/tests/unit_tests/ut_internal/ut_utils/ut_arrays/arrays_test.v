module ut_arrays


// internal
import internal.utils.arrays


fn test__array_to_fixed_1__should_return_a_correct_array() {
  input := [1]

  expected := [1]!
  actual := arrays.array_to_fixed_1(input)

  assert expected == actual
}

fn test__array_to_fixed_1__should_return_an_array_with_all_zeros() {
  input := []i32{}

  expected := [i32(0)]!
  actual := arrays.array_to_fixed_1(input)

  assert expected == actual
}

fn test__array_to_fixed_1__should_return_only_first_element_of_input() {
  input := [1, 2, 3, 4, 5]

  expected := [1]!
  actual := arrays.array_to_fixed_1(input)

  assert expected == actual
}

fn test__array_to_fixed_2__should_return_a_correct_array() {
  input := [1, 2]

  expected := [1, 2]!
  actual := arrays.array_to_fixed_2(input)

  assert expected == actual
}

fn test__array_to_fixed_2__should_return_an_array_with_all_zeros() {
  input := []i32{}

  expected := [i32(0), 0]!
  actual := arrays.array_to_fixed_2(input)

  assert expected == actual
}

fn test__array_to_fixed_2__should_return_only_two_element_of_input() {
  input := [1, 2, 3, 4, 5]

  expected := [1, 2]!
  actual := arrays.array_to_fixed_2(input)

  assert expected == actual
}

fn test__array_to_fixed_4__should_return_a_correct_array() {
  input := [1, 2, 3, 4]

  expected := [1, 2, 3, 4]!
  actual := arrays.array_to_fixed_4(input)

  assert expected == actual
}

fn test__array_to_fixed_4__should_return_an_array_with_all_zeros() {
  input := []i32{}

  expected := [i32(0), 0, 0, 0]!
  actual := arrays.array_to_fixed_4(input)

  assert expected == actual
}

fn test__array_to_fixed_4__should_return_only_four_elements_of_input() {
  input := [1, 2, 3, 4, 5]

  expected := [1, 2, 3, 4]!
  actual := arrays.array_to_fixed_4(input)

  assert expected == actual
}

fn test__array_to_fixed_8__should_return_a_correct_array() {
  input := [1, 2, 3, 4, 5, 6, 7, 8]

  expected := [1, 2, 3, 4, 5, 6, 7, 8]!
  actual := arrays.array_to_fixed_8(input)

  assert expected == actual
}

fn test__array_to_fixed_8__should_return_an_array_with_all_zeros() {
  input := []i32{}

  expected := [i32(0), 0, 0, 0, 0, 0, 0, 0]!
  actual := arrays.array_to_fixed_8(input)

  assert expected == actual
}

fn test__array_to_fixed_8__should_return_only_eight_elements_of_input() {
  input := [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

  expected := [1, 2, 3, 4, 5, 6, 7, 8]!
  actual := arrays.array_to_fixed_8(input)

  assert expected == actual
}
