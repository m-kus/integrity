use cairo_verifier::{
    domains::StarkDomains,
    air::layouts::dynamic::{
        global_values::GlobalValues, constants::{CONSTRAINT_DEGREE, MASK_SIZE, DynamicParams}
    },
    common::{math::{Felt252Div, pow}, asserts::{assert_is_power_of_2, assert_range_u128_from_u256}},
};

fn eval_composition_polynomial_inner(
    mut mask_values: Span<felt252>,
    mut constraint_coefficients: Span<felt252>,
    point: felt252,
    trace_generator: felt252,
    global_values: GlobalValues
) -> felt252 { // TODO REWRITE
    0
}

fn eval_oods_polynomial_inner(
    mut column_values: Span<felt252>,
    mut oods_values: Span<felt252>,
    mut constraint_coefficients: Span<felt252>,
    point: felt252,
    oods_point: felt252,
    trace_generator: felt252,
) -> felt252 { // TODO REWRITE
    0
}

fn check_asserts(dynamic_params: @DynamicParams, stark_domains: @StarkDomains) {
    let trace_length: u256 = (*stark_domains.trace_domain_size).into();

    let mut x = 0;

    // Coset step (dynamicparam(diluted_units_row_ratio)) must be a power of two.
     x = dynamic_params.diluted_units_row_ratio;
    assert_is_power_of_2(x.into());
    // Dimension should be a power of 2.
     x = (trace_length /  dynamic_params.diluted_units_row_ratio);
    assert_is_power_of_2(x.into());
    // Index out of range.
     x = (trace_length /  dynamic_params.diluted_units_row_ratio) - 1;
    assert_range_u128_from_u256(x);
    
    // Coset step (memberexpression(trace_length)) must be a power of two.
     x = trace_length;
    assert_is_power_of_2(x.into());
    // Index should be non negative.
     x = (trace_length /  dynamic_params.diluted_units_row_ratio);
    assert_range_u128_from_u256(x);
    
    // Coset step (dynamicparam(range_check_units_row_ratio)) must be a power of two.
     x = dynamic_params.range_check_units_row_ratio;
    assert_is_power_of_2(x.into());
    // Dimension should be a power of 2.
     x = (trace_length /  dynamic_params.range_check_units_row_ratio);
    assert_is_power_of_2(x.into());
    // Index out of range.
     x = (trace_length /  dynamic_params.range_check_units_row_ratio) - 1;
    assert_range_u128_from_u256(x);
    
    // Index should be non negative.
     x = (trace_length /  dynamic_params.range_check_units_row_ratio);
    assert_range_u128_from_u256(x);
    
    // Coset step ((8) * (dynamicparam(memory_units_row_ratio))) must be a power of two.
     x = (8 * dynamic_params.memory_units_row_ratio);
    assert_is_power_of_2(x.into());
    // Dimension should be a power of 2.
     x = (trace_length /  (8 * dynamic_params.memory_units_row_ratio));
    assert_is_power_of_2(x.into());
    // Coset step (dynamicparam(memory_units_row_ratio)) must be a power of two.
     x = dynamic_params.memory_units_row_ratio;
    assert_is_power_of_2(x.into());
    // Dimension should be a power of 2.
     x = (trace_length /  dynamic_params.memory_units_row_ratio);
    assert_is_power_of_2(x.into());
    // Index out of range.
     x = (trace_length /  dynamic_params.memory_units_row_ratio) - 1;
    assert_range_u128_from_u256(x);
    
    // Index should be non negative.
     x = (trace_length /  dynamic_params.memory_units_row_ratio);
    assert_range_u128_from_u256(x);
    
    // Coset step ((16) * (dynamicparam(cpu_component_step))) must be a power of two.
     x = (16 * dynamic_params.cpu_component_step);
    assert_is_power_of_2(x.into());
    // Dimension should be a power of 2.
     x = (trace_length /  (16 * dynamic_params.cpu_component_step));
    assert_is_power_of_2(x.into());
    // Step must not exceed dimension.
     x = (trace_length /  (16 * dynamic_params.cpu_component_step)) - 1;
    assert_range_u128_from_u256(x);
    
    // Coset step (dynamicparam(cpu_component_step)) must be a power of two.
     x = dynamic_params.cpu_component_step;
    assert_is_power_of_2(x.into());
    // Index out of range.
     x = (trace_length /  (16 * dynamic_params.cpu_component_step));
    assert_range_u128_from_u256(x);
    
    // Cpu_component_step is out of range.
     x = 256 - dynamic_params.cpu_component_step;
    assert_range_u128_from_u256(x);
    
    // Memory_units_row_ratio is out of range.
     x = 16 * dynamic_params.cpu_component_step - 
        4 * dynamic_params.memory_units_row_ratio;
    assert_range_u128_from_u256(x);
    
    // Offset of cpu/decode/mem_inst must be nonnegative.
     x = dynamic_params.cpu_decode_mem_inst_suboffset;
    assert_range_u128_from_u256(x);
    
    // Offset of cpu/decode/mem_inst is too big.
     x = trace_length - dynamic_params.cpu_decode_mem_inst_suboffset - 1;
    assert_range_u128_from_u256(x);
    
    // Offset of cpu/decode/mem_inst is too big.
     x = (16 * dynamic_params.cpu_component_step - dynamic_params.cpu_decode_mem_inst_suboffset * dynamic_params.memory_units_row_ratio) - 1;
    assert_range_u128_from_u256(x);
    
    // Offset of cpu/decode/off0 must be nonnegative.
     x = dynamic_params.cpu_decode_off0_suboffset;
    assert_range_u128_from_u256(x);
    
    // Offset of cpu/decode/off0 is too big.
     x = trace_length - dynamic_params.cpu_decode_off0_suboffset - 1;
    assert_range_u128_from_u256(x);
    
    // Offset of cpu/decode/off0 is too big.
     x = (16 * dynamic_params.cpu_component_step - dynamic_params.cpu_decode_off0_suboffset * dynamic_params.range_check_units_row_ratio) - 1;
    assert_range_u128_from_u256(x);
    
    // Offset of cpu/decode/off1 must be nonnegative.
     x = dynamic_params.cpu_decode_off1_suboffset;
    assert_range_u128_from_u256(x);
    
    // Offset of cpu/decode/off1 is too big.
     x = trace_length - dynamic_params.cpu_decode_off1_suboffset - 1;
    assert_range_u128_from_u256(x);
    
    // Offset of cpu/decode/off1 is too big.
     x = (16 * dynamic_params.cpu_component_step - dynamic_params.cpu_decode_off1_suboffset * dynamic_params.range_check_units_row_ratio) - 1;
    assert_range_u128_from_u256(x);
    
    // Offset of cpu/decode/off2 must be nonnegative.
     x = dynamic_params.cpu_decode_off2_suboffset;
    assert_range_u128_from_u256(x);
    
    // Offset of cpu/decode/off2 is too big.
     x = trace_length - dynamic_params.cpu_decode_off2_suboffset - 1;
    assert_range_u128_from_u256(x);
    
    // Offset of cpu/decode/off2 is too big.
     x = (16 * dynamic_params.cpu_component_step - dynamic_params.cpu_decode_off2_suboffset * dynamic_params.range_check_units_row_ratio) - 1;
    assert_range_u128_from_u256(x);
    
    // Offset of cpu/operands/mem_dst must be nonnegative.
     x = dynamic_params.cpu_operands_mem_dst_suboffset;
    assert_range_u128_from_u256(x);
    
    // Offset of cpu/operands/mem_dst is too big.
     x = trace_length - dynamic_params.cpu_operands_mem_dst_suboffset - 1;
    assert_range_u128_from_u256(x);
    
    // Offset of cpu/operands/mem_dst is too big.
     x = (16 * dynamic_params.cpu_component_step - dynamic_params.cpu_operands_mem_dst_suboffset * dynamic_params.memory_units_row_ratio) - 1;
    assert_range_u128_from_u256(x);
    
    // Offset of cpu/operands/mem_op0 must be nonnegative.
     x = dynamic_params.cpu_operands_mem_op0_suboffset;
    assert_range_u128_from_u256(x);
    
    // Offset of cpu/operands/mem_op0 is too big.
     x = trace_length - dynamic_params.cpu_operands_mem_op0_suboffset - 1;
    assert_range_u128_from_u256(x);
    
    // Offset of cpu/operands/mem_op0 is too big.
     x = (16 * dynamic_params.cpu_component_step - dynamic_params.cpu_operands_mem_op0_suboffset * dynamic_params.memory_units_row_ratio) - 1;
    assert_range_u128_from_u256(x);
    
    // Offset of cpu/operands/mem_op1 must be nonnegative.
     x = dynamic_params.cpu_operands_mem_op1_suboffset;
    assert_range_u128_from_u256(x);
    
    // Offset of cpu/operands/mem_op1 is too big.
     x = trace_length - dynamic_params.cpu_operands_mem_op1_suboffset - 1;
    assert_range_u128_from_u256(x);
    
    // Offset of cpu/operands/mem_op1 is too big.
     x = (16 * dynamic_params.cpu_component_step - dynamic_params.cpu_operands_mem_op1_suboffset * dynamic_params.memory_units_row_ratio) - 1;
    assert_range_u128_from_u256(x);
    
    // Offset of orig/public_memory must be nonnegative.
     x = dynamic_params.orig_public_memory_suboffset;
    assert_range_u128_from_u256(x);
    
    // Offset of orig/public_memory is too big.
     x = trace_length - dynamic_params.orig_public_memory_suboffset - 1;
    assert_range_u128_from_u256(x);
    
    // Offset of orig/public_memory is too big.
     x = (8 * dynamic_params.memory_units_row_ratio - dynamic_params.orig_public_memory_suboffset * dynamic_params.memory_units_row_ratio) - 1;
    assert_range_u128_from_u256(x);
    
    // Uses_pedersen_builtin should be a boolean.
    assert (dynamic_params.uses_pedersen_builtin * dynamic_params.uses_pedersen_builtin - dynamic_params.uses_pedersen_builtin == 0);
    // Uses_range_check_builtin should be a boolean.
    assert (dynamic_params.uses_range_check_builtin * dynamic_params.uses_range_check_builtin - dynamic_params.uses_range_check_builtin == 0);
    // Uses_ecdsa_builtin should be a boolean.
    assert (dynamic_params.uses_ecdsa_builtin * dynamic_params.uses_ecdsa_builtin - dynamic_params.uses_ecdsa_builtin == 0);
    // Uses_bitwise_builtin should be a boolean.
    assert (dynamic_params.uses_bitwise_builtin * dynamic_params.uses_bitwise_builtin - dynamic_params.uses_bitwise_builtin == 0);
    // Uses_ec_op_builtin should be a boolean.
    assert (dynamic_params.uses_ec_op_builtin * dynamic_params.uses_ec_op_builtin -
        dynamic_params.uses_ec_op_builtin == 0);
    // Uses_keccak_builtin should be a boolean.
    assert (dynamic_params.uses_keccak_builtin * dynamic_params.uses_keccak_builtin -
        dynamic_params.uses_keccak_builtin == 0);
    // Uses_poseidon_builtin should be a boolean.
    assert (dynamic_params.uses_poseidon_builtin * dynamic_params.uses_poseidon_builtin -
        dynamic_params.uses_poseidon_builtin == 0);
    // Uses_range_check96_builtin should be a boolean.
    assert (dynamic_params.uses_range_check96_builtin * dynamic_params.uses_range_check96_builtin - dynamic_params.uses_range_check96_builtin == 0);
    // Uses_add_mod_builtin should be a boolean.
    assert (dynamic_params.uses_add_mod_builtin * dynamic_params.uses_add_mod_builtin - dynamic_params.uses_add_mod_builtin == 0);
    // Uses_mul_mod_builtin should be a boolean.
    assert (dynamic_params.uses_mul_mod_builtin * dynamic_params.uses_mul_mod_builtin - dynamic_params.uses_mul_mod_builtin == 0);
    // Num_columns_first is out of range.
     x = 65536 - dynamic_params.num_columns_first - 1;
    assert_range_u128_from_u256(x);
    
    // Num_columns_second is out of range.
     x = 65536 - dynamic_params.num_columns_second - 1;
    assert_range_u128_from_u256(x);
    
    // Column index out of range.
     x = dynamic_params.mem_pool_addr_column;
    assert_range_u128_from_u256(x);
    
    // Column index out of range.
     x = dynamic_params.num_columns_first - dynamic_params.mem_pool_addr_column - 1;
    assert_range_u128_from_u256(x);
    
    // Offset must be nonnegative.
     x = dynamic_params.mem_pool_addr_offset;
    assert_range_u128_from_u256(x);
    
    // Offset must be smaller than trace length.
     x = trace_length - dynamic_params.mem_pool_addr_offset - 1;
    assert_range_u128_from_u256(x);
    
    // Column index out of range.
     x = dynamic_params.mem_pool_value_column;
    assert_range_u128_from_u256(x);
    
    // Column index out of range.
     x = dynamic_params.num_columns_first - dynamic_params.mem_pool_value_column - 1;
    assert_range_u128_from_u256(x);
    
    // Offset must be nonnegative.
     x = dynamic_params.mem_pool_value_offset;
    assert_range_u128_from_u256(x);
    
    // Offset must be smaller than trace length.
     x = trace_length - dynamic_params.mem_pool_value_offset - 1;
    assert_range_u128_from_u256(x);
    
    // Column index out of range.
     x = dynamic_params.range_check16_pool_column;
    assert_range_u128_from_u256(x);
    
    // Column index out of range.
     x = dynamic_params.num_columns_first - dynamic_params.range_check16_pool_column - 1;
    assert_range_u128_from_u256(x);
    
    // Offset must be nonnegative.
     x = dynamic_params.range_check16_pool_offset;
    assert_range_u128_from_u256(x);
    
    // Offset must be smaller than trace length.
     x = trace_length - dynamic_params.range_check16_pool_offset - 1;
    assert_range_u128_from_u256(x);
    
    // Column index out of range.
     x = dynamic_params.cpu_decode_opcode_range_check_column_column;
    assert_range_u128_from_u256(x);
    
    // Column index out of range.
     x = dynamic_params.num_columns_first -
        dynamic_params.cpu_decode_opcode_range_check_column_column - 1;
    assert_range_u128_from_u256(x);
    
    // Offset must be nonnegative.
     x = dynamic_params.cpu_decode_opcode_range_check_column_offset;
    assert_range_u128_from_u256(x);
    
    // Offset must be smaller than trace length.
     x = trace_length - dynamic_params.cpu_decode_opcode_range_check_column_offset - 1;
    assert_range_u128_from_u256(x);
    
    // Column index out of range.
     x = dynamic_params.cpu_registers_ap_column;
    assert_range_u128_from_u256(x);
    
    // Column index out of range.
     x = dynamic_params.num_columns_first - dynamic_params.cpu_registers_ap_column - 1;
    assert_range_u128_from_u256(x);
    
    // Offset must be nonnegative.
     x = dynamic_params.cpu_registers_ap_offset;
    assert_range_u128_from_u256(x);
    
    // Offset must be smaller than trace length.
     x = trace_length - dynamic_params.cpu_registers_ap_offset - 1;
    assert_range_u128_from_u256(x);
    
    // Column index out of range.
     x = dynamic_params.cpu_registers_fp_column;
    assert_range_u128_from_u256(x);
    
    // Column index out of range.
     x = dynamic_params.num_columns_first - dynamic_params.cpu_registers_fp_column - 1;
    assert_range_u128_from_u256(x);
    
    // Offset must be nonnegative.
     x = dynamic_params.cpu_registers_fp_offset;
    assert_range_u128_from_u256(x);
    
    // Offset must be smaller than trace length.
     x = trace_length - dynamic_params.cpu_registers_fp_offset - 1;
    assert_range_u128_from_u256(x);
    
    // Column index out of range.
     x = dynamic_params.cpu_operands_ops_mul_column;
    assert_range_u128_from_u256(x);
    
    // Column index out of range.
     x = dynamic_params.num_columns_first - dynamic_params.cpu_operands_ops_mul_column - 1;
    assert_range_u128_from_u256(x);
    
    // Offset must be nonnegative.
     x = dynamic_params.cpu_operands_ops_mul_offset;
    assert_range_u128_from_u256(x);
    
    // Offset must be smaller than trace length.
     x = trace_length - dynamic_params.cpu_operands_ops_mul_offset - 1;
    assert_range_u128_from_u256(x);
    
    // Column index out of range.
     x = dynamic_params.cpu_operands_res_column;
    assert_range_u128_from_u256(x);
    
    // Column index out of range.
     x = dynamic_params.num_columns_first - dynamic_params.cpu_operands_res_column - 1;
    assert_range_u128_from_u256(x);
    
    // Offset must be nonnegative.
     x = dynamic_params.cpu_operands_res_offset;
    assert_range_u128_from_u256(x);
    
    // Offset must be smaller than trace length.
     x = trace_length - dynamic_params.cpu_operands_res_offset - 1;
    assert_range_u128_from_u256(x);
    
    // Column index out of range.
     x = dynamic_params.cpu_update_registers_update_pc_tmp0_column;
    assert_range_u128_from_u256(x);
    
    // Column index out of range.
     x = dynamic_params.num_columns_first -
        dynamic_params.cpu_update_registers_update_pc_tmp0_column - 1;
    assert_range_u128_from_u256(x);
    
    // Offset must be nonnegative.
     x = dynamic_params.cpu_update_registers_update_pc_tmp0_offset;
    assert_range_u128_from_u256(x);
    
    // Offset must be smaller than trace length.
     x = trace_length - dynamic_params.cpu_update_registers_update_pc_tmp0_offset - 1;
    assert_range_u128_from_u256(x);
    
    // Column index out of range.
     x = dynamic_params.cpu_update_registers_update_pc_tmp1_column;
    assert_range_u128_from_u256(x);
    
    // Column index out of range.
     x = dynamic_params.num_columns_first -
        dynamic_params.cpu_update_registers_update_pc_tmp1_column - 1;
    assert_range_u128_from_u256(x);
    
    // Offset must be nonnegative.
     x = dynamic_params.cpu_update_registers_update_pc_tmp1_offset;
    assert_range_u128_from_u256(x);
    
    // Offset must be smaller than trace length.
     x = trace_length - dynamic_params.cpu_update_registers_update_pc_tmp1_offset - 1;
    assert_range_u128_from_u256(x);
    
    // Column index out of range.
     x = dynamic_params.memory_sorted_addr_column;
    assert_range_u128_from_u256(x);
    
    // Column index out of range.
     x = dynamic_params.num_columns_first - dynamic_params.memory_sorted_addr_column - 1;
    assert_range_u128_from_u256(x);
    
    // Offset must be nonnegative.
     x = dynamic_params.memory_sorted_addr_offset;
    assert_range_u128_from_u256(x);
    
    // Offset must be smaller than trace length.
     x = trace_length - dynamic_params.memory_sorted_addr_offset - 1;
    assert_range_u128_from_u256(x);
    
    // Column index out of range.
     x = dynamic_params.memory_sorted_value_column;
    assert_range_u128_from_u256(x);
    
    // Column index out of range.
     x = dynamic_params.num_columns_first - dynamic_params.memory_sorted_value_column - 1;
    assert_range_u128_from_u256(x);
    
    // Offset must be nonnegative.
     x = dynamic_params.memory_sorted_value_offset;
    assert_range_u128_from_u256(x);
    
    // Offset must be smaller than trace length.
     x = trace_length - dynamic_params.memory_sorted_value_offset - 1;
    assert_range_u128_from_u256(x);
    
    // Column index out of range.
     x = dynamic_params.range_check16_sorted_column;
    assert_range_u128_from_u256(x);
    
    // Column index out of range.
     x = dynamic_params.num_columns_first - dynamic_params.range_check16_sorted_column - 1;
    assert_range_u128_from_u256(x);
    
    // Offset must be nonnegative.
     x = dynamic_params.range_check16_sorted_offset;
    assert_range_u128_from_u256(x);
    
    // Offset must be smaller than trace length.
     x = trace_length - dynamic_params.range_check16_sorted_offset - 1;
    assert_range_u128_from_u256(x);
    
    // Column index out of range.
     x = dynamic_params.diluted_pool_column;
    assert_range_u128_from_u256(x);
    
    // Column index out of range.
     x = dynamic_params.num_columns_first - dynamic_params.diluted_pool_column - 1;
    assert_range_u128_from_u256(x);
    
    // Offset must be nonnegative.
     x = dynamic_params.diluted_pool_offset;
    assert_range_u128_from_u256(x);
    
    // Offset must be smaller than trace length.
     x = trace_length - dynamic_params.diluted_pool_offset - 1;
    assert_range_u128_from_u256(x);
    
    // Column index out of range.
     x = dynamic_params.diluted_check_permuted_values_column;
    assert_range_u128_from_u256(x);
    
    // Column index out of range.
     x = dynamic_params.num_columns_first -
        dynamic_params.diluted_check_permuted_values_column - 1;
    assert_range_u128_from_u256(x);
    
    // Offset must be nonnegative.
     x = dynamic_params.diluted_check_permuted_values_offset;
    assert_range_u128_from_u256(x);
    
    // Offset must be smaller than trace length.
     x = trace_length - dynamic_params.diluted_check_permuted_values_offset - 1;
    assert_range_u128_from_u256(x);
    
    // Column index out of range.
     x = dynamic_params.pedersen_hash0_ec_subset_sum_partial_sum_x_column;
    assert_range_u128_from_u256(x);
    
    // Column index out of range.
     x = dynamic_params.num_columns_first -
        dynamic_params.pedersen_hash0_ec_subset_sum_partial_sum_x_column - 1;
    assert_range_u128_from_u256(x);
    
    // Offset must be nonnegative.
     x = dynamic_params.pedersen_hash0_ec_subset_sum_partial_sum_x_offset;
    assert_range_u128_from_u256(x);
    
    // Offset must be smaller than trace length.
     x = trace_length -
        dynamic_params.pedersen_hash0_ec_subset_sum_partial_sum_x_offset - 1;
    assert_range_u128_from_u256(x);
    
    // Column index out of range.
     x = dynamic_params.pedersen_hash0_ec_subset_sum_partial_sum_y_column;
    assert_range_u128_from_u256(x);
    
    // Column index out of range.
     x = dynamic_params.num_columns_first -
        dynamic_params.pedersen_hash0_ec_subset_sum_partial_sum_y_column - 1;
    assert_range_u128_from_u256(x);
    
    // Offset must be nonnegative.
     x = dynamic_params.pedersen_hash0_ec_subset_sum_partial_sum_y_offset;
    assert_range_u128_from_u256(x);
    
    // Offset must be smaller than trace length.
     x = trace_length -
        dynamic_params.pedersen_hash0_ec_subset_sum_partial_sum_y_offset - 1;
    assert_range_u128_from_u256(x);
    
    // Column index out of range.
     x = dynamic_params.pedersen_hash0_ec_subset_sum_slope_column;
    assert_range_u128_from_u256(x);
    
    // Column index out of range.
     x = dynamic_params.num_columns_first -
        dynamic_params.pedersen_hash0_ec_subset_sum_slope_column - 1;
    assert_range_u128_from_u256(x);
    
    // Offset must be nonnegative.
     x = dynamic_params.pedersen_hash0_ec_subset_sum_slope_offset;
    assert_range_u128_from_u256(x);
    
    // Offset must be smaller than trace length.
     x = trace_length - dynamic_params.pedersen_hash0_ec_subset_sum_slope_offset - 1;
    assert_range_u128_from_u256(x);
    
    // Column index out of range.
     x = dynamic_params.pedersen_hash0_ec_subset_sum_selector_column;
    assert_range_u128_from_u256(x);
    
    // Column index out of range.
     x = dynamic_params.num_columns_first -
        dynamic_params.pedersen_hash0_ec_subset_sum_selector_column - 1;
    assert_range_u128_from_u256(x);
    
    // Offset must be nonnegative.
     x = dynamic_params.pedersen_hash0_ec_subset_sum_selector_offset;
    assert_range_u128_from_u256(x);
    
    // Offset must be smaller than trace length.
     x = trace_length - dynamic_params.pedersen_hash0_ec_subset_sum_selector_offset - 1;
    assert_range_u128_from_u256(x);
    
    // Column index out of range.
     x = dynamic_params.pedersen_hash0_ec_subset_sum_bit_unpacking_prod_ones196_column;
    assert_range_u128_from_u256(x);
    
    // Column index out of range.
     x = dynamic_params.num_columns_first -
        dynamic_params.pedersen_hash0_ec_subset_sum_bit_unpacking_prod_ones196_column - 1;
    assert_range_u128_from_u256(x);
    
    // Offset must be nonnegative.
     x = dynamic_params.pedersen_hash0_ec_subset_sum_bit_unpacking_prod_ones196_offset;
    assert_range_u128_from_u256(x);
    
    // Offset must be smaller than trace length.
     x = trace_length -
        dynamic_params.pedersen_hash0_ec_subset_sum_bit_unpacking_prod_ones196_offset - 1;
    assert_range_u128_from_u256(x);
    
    // Column index out of range.
     x = dynamic_params.pedersen_hash0_ec_subset_sum_bit_unpacking_prod_ones192_column;
    assert_range_u128_from_u256(x);
    
    // Column index out of range.
     x = dynamic_params.num_columns_first -
        dynamic_params.pedersen_hash0_ec_subset_sum_bit_unpacking_prod_ones192_column - 1;
    assert_range_u128_from_u256(x);
    
    // Offset must be nonnegative.
     x = dynamic_params.pedersen_hash0_ec_subset_sum_bit_unpacking_prod_ones192_offset;
    assert_range_u128_from_u256(x);
    
    // Offset must be smaller than trace length.
     x = trace_length -
        dynamic_params.pedersen_hash0_ec_subset_sum_bit_unpacking_prod_ones192_offset - 1;
    assert_range_u128_from_u256(x);
    
    // Column index out of range.
     x = dynamic_params.ecdsa_signature0_key_points_x_column;
    assert_range_u128_from_u256(x);
    
    // Column index out of range.
     x = dynamic_params.num_columns_first -
        dynamic_params.ecdsa_signature0_key_points_x_column - 1;
    assert_range_u128_from_u256(x);
    
    // Offset must be nonnegative.
     x = dynamic_params.ecdsa_signature0_key_points_x_offset;
    assert_range_u128_from_u256(x);
    
    // Offset must be smaller than trace length.
     x = trace_length - dynamic_params.ecdsa_signature0_key_points_x_offset - 1;
    assert_range_u128_from_u256(x);
    
    // Column index out of range.
     x = dynamic_params.ecdsa_signature0_key_points_y_column;
    assert_range_u128_from_u256(x);
    
    // Column index out of range.
     x = dynamic_params.num_columns_first -
        dynamic_params.ecdsa_signature0_key_points_y_column - 1;
    assert_range_u128_from_u256(x);
    
    // Offset must be nonnegative.
     x = dynamic_params.ecdsa_signature0_key_points_y_offset;
    assert_range_u128_from_u256(x);
    
    // Offset must be smaller than trace length.
     x = trace_length - dynamic_params.ecdsa_signature0_key_points_y_offset - 1;
    assert_range_u128_from_u256(x);
    
    // Column index out of range.
     x = dynamic_params.ecdsa_signature0_doubling_slope_column;
    assert_range_u128_from_u256(x);
    
    // Column index out of range.
     x = dynamic_params.num_columns_first -
        dynamic_params.ecdsa_signature0_doubling_slope_column - 1;
    assert_range_u128_from_u256(x);
    
    // Offset must be nonnegative.
     x = dynamic_params.ecdsa_signature0_doubling_slope_offset;
    assert_range_u128_from_u256(x);
    
    // Offset must be smaller than trace length.
     x = trace_length - dynamic_params.ecdsa_signature0_doubling_slope_offset - 1;
    assert_range_u128_from_u256(x);
    
    // Column index out of range.
     x = dynamic_params.ecdsa_signature0_exponentiate_generator_partial_sum_x_column;
    assert_range_u128_from_u256(x);
    
    // Column index out of range.
     x = dynamic_params.num_columns_first -
        dynamic_params.ecdsa_signature0_exponentiate_generator_partial_sum_x_column - 1;
    assert_range_u128_from_u256(x);
    
    // Offset must be nonnegative.
     x = dynamic_params.ecdsa_signature0_exponentiate_generator_partial_sum_x_offset;
    assert_range_u128_from_u256(x);
    
    // Offset must be smaller than trace length.
     x = trace_length -
        dynamic_params.ecdsa_signature0_exponentiate_generator_partial_sum_x_offset - 1;
    assert_range_u128_from_u256(x);
    
    // Column index out of range.
     x = dynamic_params.ecdsa_signature0_exponentiate_generator_partial_sum_y_column;
    assert_range_u128_from_u256(x);
    
    // Column index out of range.
     x = dynamic_params.num_columns_first -
        dynamic_params.ecdsa_signature0_exponentiate_generator_partial_sum_y_column - 1;
    assert_range_u128_from_u256(x);
    
    // Offset must be nonnegative.
     x = dynamic_params.ecdsa_signature0_exponentiate_generator_partial_sum_y_offset;
    assert_range_u128_from_u256(x);
    
    // Offset must be smaller than trace length.
     x = trace_length -
        dynamic_params.ecdsa_signature0_exponentiate_generator_partial_sum_y_offset - 1;
    assert_range_u128_from_u256(x);
    
    // Column index out of range.
     x = dynamic_params.ecdsa_signature0_exponentiate_generator_slope_column;
    assert_range_u128_from_u256(x);
    
    // Column index out of range.
     x = dynamic_params.num_columns_first -
        dynamic_params.ecdsa_signature0_exponentiate_generator_slope_column - 1;
    assert_range_u128_from_u256(x);
    
    // Offset must be nonnegative.
     x = dynamic_params.ecdsa_signature0_exponentiate_generator_slope_offset;
    assert_range_u128_from_u256(x);
    
    // Offset must be smaller than trace length.
     x = trace_length -
        dynamic_params.ecdsa_signature0_exponentiate_generator_slope_offset - 1;
    assert_range_u128_from_u256(x);
    
    // Column index out of range.
     x = dynamic_params.ecdsa_signature0_exponentiate_generator_selector_column;
    assert_range_u128_from_u256(x);
    
    // Column index out of range.
     x = dynamic_params.num_columns_first -
        dynamic_params.ecdsa_signature0_exponentiate_generator_selector_column - 1;
    assert_range_u128_from_u256(x);
    
    // Offset must be nonnegative.
     x = dynamic_params.ecdsa_signature0_exponentiate_generator_selector_offset;
    assert_range_u128_from_u256(x);
    
    // Offset must be smaller than trace length.
     x = trace_length -
        dynamic_params.ecdsa_signature0_exponentiate_generator_selector_offset - 1;
    assert_range_u128_from_u256(x);
    
    // Column index out of range.
     x = dynamic_params.ecdsa_signature0_exponentiate_generator_x_diff_inv_column;
    assert_range_u128_from_u256(x);
    
    // Column index out of range.
     x = dynamic_params.num_columns_first -
        dynamic_params.ecdsa_signature0_exponentiate_generator_x_diff_inv_column - 1;
    assert_range_u128_from_u256(x);
    
    // Offset must be nonnegative.
     x = dynamic_params.ecdsa_signature0_exponentiate_generator_x_diff_inv_offset;
    assert_range_u128_from_u256(x);
    
    // Offset must be smaller than trace length.
     x = trace_length -
        dynamic_params.ecdsa_signature0_exponentiate_generator_x_diff_inv_offset - 1;
    assert_range_u128_from_u256(x);
    
    // Column index out of range.
     x = dynamic_params.ecdsa_signature0_exponentiate_key_partial_sum_x_column;
    assert_range_u128_from_u256(x);
    
    // Column index out of range.
     x = dynamic_params.num_columns_first -
        dynamic_params.ecdsa_signature0_exponentiate_key_partial_sum_x_column - 1;
    assert_range_u128_from_u256(x);
    
    // Offset must be nonnegative.
     x = dynamic_params.ecdsa_signature0_exponentiate_key_partial_sum_x_offset;
    assert_range_u128_from_u256(x);
    
    // Offset must be smaller than trace length.
     x = trace_length - dynamic_params.ecdsa_signature0_exponentiate_key_partial_sum_x_offset - 1;
    assert_range_u128_from_u256(x);
    
    // Column index out of range.
     x = dynamic_params.ecdsa_signature0_exponentiate_key_partial_sum_y_column;
    assert_range_u128_from_u256(x);
    
    // Column index out of range.
     x = dynamic_params.num_columns_first -
        dynamic_params.ecdsa_signature0_exponentiate_key_partial_sum_y_column - 1;
    assert_range_u128_from_u256(x);
    
    // Offset must be nonnegative.
     x = dynamic_params.ecdsa_signature0_exponentiate_key_partial_sum_y_offset;
    assert_range_u128_from_u256(x);
    
    // Offset must be smaller than trace length.
     x = trace_length -
        dynamic_params.ecdsa_signature0_exponentiate_key_partial_sum_y_offset - 1;
    assert_range_u128_from_u256(x);
    
    // Column index out of range.
     x = dynamic_params.ecdsa_signature0_exponentiate_key_slope_column;
    assert_range_u128_from_u256(x);
    
    // Column index out of range.
     x = dynamic_params.num_columns_first -
        dynamic_params.ecdsa_signature0_exponentiate_key_slope_column - 1;
    assert_range_u128_from_u256(x);
    
    // Offset must be nonnegative.
     x = dynamic_params.ecdsa_signature0_exponentiate_key_slope_offset;
    assert_range_u128_from_u256(x);
    
    // Offset must be smaller than trace length.
     x = trace_length - dynamic_params.ecdsa_signature0_exponentiate_key_slope_offset - 1;
    assert_range_u128_from_u256(x);
    
    // Column index out of range.
     x = dynamic_params.ecdsa_signature0_exponentiate_key_selector_column;
    assert_range_u128_from_u256(x);
    
    // Column index out of range.
     x = dynamic_params.num_columns_first -
        dynamic_params.ecdsa_signature0_exponentiate_key_selector_column - 1;
    assert_range_u128_from_u256(x);
    
    // Offset must be nonnegative.
     x = dynamic_params.ecdsa_signature0_exponentiate_key_selector_offset;
    assert_range_u128_from_u256(x);
    
    // Offset must be smaller than trace length.
     x = trace_length - dynamic_params.ecdsa_signature0_exponentiate_key_selector_offset -
        1;
    assert_range_u128_from_u256(x);
    
    // Column index out of range.
     x = dynamic_params.ecdsa_signature0_exponentiate_key_x_diff_inv_column;
    assert_range_u128_from_u256(x);
    
    // Column index out of range.
     x = dynamic_params.num_columns_first -
        dynamic_params.ecdsa_signature0_exponentiate_key_x_diff_inv_column - 1;
    assert_range_u128_from_u256(x);
    
    // Offset must be nonnegative.
     x = dynamic_params.ecdsa_signature0_exponentiate_key_x_diff_inv_offset;
    assert_range_u128_from_u256(x);
    
    // Offset must be smaller than trace length.
     x = trace_length -
        dynamic_params.ecdsa_signature0_exponentiate_key_x_diff_inv_offset - 1;
    assert_range_u128_from_u256(x);
    
    // Column index out of range.
     x = dynamic_params.ecdsa_signature0_add_results_slope_column;
    assert_range_u128_from_u256(x);
    
    // Column index out of range.
     x = dynamic_params.num_columns_first -
        dynamic_params.ecdsa_signature0_add_results_slope_column - 1;
    assert_range_u128_from_u256(x);
    
    // Offset must be nonnegative.
     x = dynamic_params.ecdsa_signature0_add_results_slope_offset;
    assert_range_u128_from_u256(x);
    
    // Offset must be smaller than trace length.
     x = trace_length - dynamic_params.ecdsa_signature0_add_results_slope_offset - 1;
    assert_range_u128_from_u256(x);
    
    // Column index out of range.
     x = dynamic_params.ecdsa_signature0_add_results_inv_column;
    assert_range_u128_from_u256(x);
    
    // Column index out of range.
     x = dynamic_params.num_columns_first -
        dynamic_params.ecdsa_signature0_add_results_inv_column - 1;
    assert_range_u128_from_u256(x);
    
    // Offset must be nonnegative.
     x = dynamic_params.ecdsa_signature0_add_results_inv_offset;
    assert_range_u128_from_u256(x);
    
    // Offset must be smaller than trace length.
     x = trace_length - dynamic_params.ecdsa_signature0_add_results_inv_offset - 1;
    assert_range_u128_from_u256(x);
    
    // Column index out of range.
     x = dynamic_params.ecdsa_signature0_extract_r_slope_column;
    assert_range_u128_from_u256(x);
    
    // Column index out of range.
     x = dynamic_params.num_columns_first -
        dynamic_params.ecdsa_signature0_extract_r_slope_column - 1;
    assert_range_u128_from_u256(x);
    
    // Offset must be nonnegative.
     x = dynamic_params.ecdsa_signature0_extract_r_slope_offset;
    assert_range_u128_from_u256(x);
    
    // Offset must be smaller than trace length.
     x = trace_length - dynamic_params.ecdsa_signature0_extract_r_slope_offset - 1;
    assert_range_u128_from_u256(x);
    
    // Column index out of range.
     x = dynamic_params.ecdsa_signature0_extract_r_inv_column;
    assert_range_u128_from_u256(x);
    
    // Column index out of range.
     x = dynamic_params.num_columns_first -
        dynamic_params.ecdsa_signature0_extract_r_inv_column - 1;
    assert_range_u128_from_u256(x);
    
    // Offset must be nonnegative.
     x = dynamic_params.ecdsa_signature0_extract_r_inv_offset;
    assert_range_u128_from_u256(x);
    
    // Offset must be smaller than trace length.
     x = trace_length - dynamic_params.ecdsa_signature0_extract_r_inv_offset - 1;
    assert_range_u128_from_u256(x);
    
    // Column index out of range.
     x = dynamic_params.ecdsa_signature0_z_inv_column;
    assert_range_u128_from_u256(x);
    
    // Column index out of range.
     x = dynamic_params.num_columns_first - dynamic_params.ecdsa_signature0_z_inv_column -
        1;
    assert_range_u128_from_u256(x);
    
    // Offset must be nonnegative.
     x = dynamic_params.ecdsa_signature0_z_inv_offset;
    assert_range_u128_from_u256(x);
    
    // Offset must be smaller than trace length.
     x = trace_length - dynamic_params.ecdsa_signature0_z_inv_offset - 1;
    assert_range_u128_from_u256(x);
    
    // Column index out of range.
     x = dynamic_params.ecdsa_signature0_r_w_inv_column;
    assert_range_u128_from_u256(x);
    
    // Column index out of range.
     x = dynamic_params.num_columns_first -
        dynamic_params.ecdsa_signature0_r_w_inv_column - 1;
    assert_range_u128_from_u256(x);
    
    // Offset must be nonnegative.
     x = dynamic_params.ecdsa_signature0_r_w_inv_offset;
    assert_range_u128_from_u256(x);
    
    // Offset must be smaller than trace length.
     x = trace_length - dynamic_params.ecdsa_signature0_r_w_inv_offset - 1;
    assert_range_u128_from_u256(x);
    
    // Column index out of range.
     x = dynamic_params.ecdsa_signature0_q_x_squared_column;
    assert_range_u128_from_u256(x);
    
    // Column index out of range.
     x = dynamic_params.num_columns_first -
        dynamic_params.ecdsa_signature0_q_x_squared_column - 1;
    assert_range_u128_from_u256(x);
    
    // Offset must be nonnegative.
     x = dynamic_params.ecdsa_signature0_q_x_squared_offset;
    assert_range_u128_from_u256(x);
    
    // Offset must be smaller than trace length.
     x = trace_length - dynamic_params.ecdsa_signature0_q_x_squared_offset - 1;
    assert_range_u128_from_u256(x);
    
    // Column index out of range.
     x = dynamic_params.ec_op_doubled_points_x_column;
    assert_range_u128_from_u256(x);
    
    // Column index out of range.
     x = dynamic_params.num_columns_first - dynamic_params.ec_op_doubled_points_x_column -
        1;
    assert_range_u128_from_u256(x);
    
    // Offset must be nonnegative.
     x = dynamic_params.ec_op_doubled_points_x_offset;
    assert_range_u128_from_u256(x);
    
    // Offset must be smaller than trace length.
     x = trace_length - dynamic_params.ec_op_doubled_points_x_offset - 1;
    assert_range_u128_from_u256(x);
    
    // Column index out of range.
     x = dynamic_params.ec_op_doubled_points_y_column;
    assert_range_u128_from_u256(x);
    
    // Column index out of range.
     x = dynamic_params.num_columns_first - dynamic_params.ec_op_doubled_points_y_column -
        1;
    assert_range_u128_from_u256(x);
    
    // Offset must be nonnegative.
     x = dynamic_params.ec_op_doubled_points_y_offset;
    assert_range_u128_from_u256(x);
    
    // Offset must be smaller than trace length.
     x = trace_length - dynamic_params.ec_op_doubled_points_y_offset - 1;
    assert_range_u128_from_u256(x);
    
    // Column index out of range.
     x = dynamic_params.ec_op_doubling_slope_column;
    assert_range_u128_from_u256(x);
    
    // Column index out of range.
     x = dynamic_params.num_columns_first - dynamic_params.ec_op_doubling_slope_column - 1;
    assert_range_u128_from_u256(x);
    
    // Offset must be nonnegative.
     x = dynamic_params.ec_op_doubling_slope_offset;
    assert_range_u128_from_u256(x);
    
    // Offset must be smaller than trace length.
     x = trace_length - dynamic_params.ec_op_doubling_slope_offset - 1;
    assert_range_u128_from_u256(x);
    
    // Column index out of range.
     x = dynamic_params.ec_op_ec_subset_sum_partial_sum_x_column;
    assert_range_u128_from_u256(x);
    
    // Column index out of range.
     x = dynamic_params.num_columns_first -
        dynamic_params.ec_op_ec_subset_sum_partial_sum_x_column - 1;
    assert_range_u128_from_u256(x);
    
    // Offset must be nonnegative.
     x = dynamic_params.ec_op_ec_subset_sum_partial_sum_x_offset;
    assert_range_u128_from_u256(x);
    
    // Offset must be smaller than trace length.
     x = trace_length - dynamic_params.ec_op_ec_subset_sum_partial_sum_x_offset - 1;
    assert_range_u128_from_u256(x);
    
    // Column index out of range.
     x = dynamic_params.ec_op_ec_subset_sum_partial_sum_y_column;
    assert_range_u128_from_u256(x);
    
    // Column index out of range.
     x = dynamic_params.num_columns_first -
        dynamic_params.ec_op_ec_subset_sum_partial_sum_y_column - 1;
    assert_range_u128_from_u256(x);
    
    // Offset must be nonnegative.
     x = dynamic_params.ec_op_ec_subset_sum_partial_sum_y_offset;
    assert_range_u128_from_u256(x);
    
    // Offset must be smaller than trace length.
     x = trace_length - dynamic_params.ec_op_ec_subset_sum_partial_sum_y_offset - 1;
    assert_range_u128_from_u256(x);
    
    // Column index out of range.
     x = dynamic_params.ec_op_ec_subset_sum_slope_column;
    assert_range_u128_from_u256(x);
    
    // Column index out of range.
     x = dynamic_params.num_columns_first -
        dynamic_params.ec_op_ec_subset_sum_slope_column - 1;
    assert_range_u128_from_u256(x);
    
    // Offset must be nonnegative.
     x = dynamic_params.ec_op_ec_subset_sum_slope_offset;
    assert_range_u128_from_u256(x);
    
    // Offset must be smaller than trace length.
     x = trace_length - dynamic_params.ec_op_ec_subset_sum_slope_offset - 1;
    assert_range_u128_from_u256(x);
    
    // Column index out of range.
     x = dynamic_params.ec_op_ec_subset_sum_selector_column;
    assert_range_u128_from_u256(x);
    
    // Column index out of range.
     x = dynamic_params.num_columns_first -
        dynamic_params.ec_op_ec_subset_sum_selector_column - 1;
    assert_range_u128_from_u256(x);
    
    // Offset must be nonnegative.
     x = dynamic_params.ec_op_ec_subset_sum_selector_offset;
    assert_range_u128_from_u256(x);
    
    // Offset must be smaller than trace length.
     x = trace_length - dynamic_params.ec_op_ec_subset_sum_selector_offset - 1;
    assert_range_u128_from_u256(x);
    
    // Column index out of range.
     x = dynamic_params.ec_op_ec_subset_sum_x_diff_inv_column;
    assert_range_u128_from_u256(x);
    
    // Column index out of range.
     x = dynamic_params.num_columns_first -
        dynamic_params.ec_op_ec_subset_sum_x_diff_inv_column - 1;
    assert_range_u128_from_u256(x);
    
    // Offset must be nonnegative.
     x = dynamic_params.ec_op_ec_subset_sum_x_diff_inv_offset;
    assert_range_u128_from_u256(x);
    
    // Offset must be smaller than trace length.
     x = trace_length - dynamic_params.ec_op_ec_subset_sum_x_diff_inv_offset - 1;
    assert_range_u128_from_u256(x);
    
    // Column index out of range.
     x = dynamic_params.ec_op_ec_subset_sum_bit_unpacking_prod_ones196_column;
    assert_range_u128_from_u256(x);
    
    // Column index out of range.
     x = dynamic_params.num_columns_first -
        dynamic_params.ec_op_ec_subset_sum_bit_unpacking_prod_ones196_column - 1;
    assert_range_u128_from_u256(x);
    
    // Offset must be nonnegative.
     x = dynamic_params.ec_op_ec_subset_sum_bit_unpacking_prod_ones196_offset;
    assert_range_u128_from_u256(x);
    
    // Offset must be smaller than trace length.
     x = trace_length -
        dynamic_params.ec_op_ec_subset_sum_bit_unpacking_prod_ones196_offset - 1;
    assert_range_u128_from_u256(x);
    
    // Column index out of range.
     x = dynamic_params.ec_op_ec_subset_sum_bit_unpacking_prod_ones192_column;
    assert_range_u128_from_u256(x);
    
    // Column index out of range.
     x = dynamic_params.num_columns_first -
        dynamic_params.ec_op_ec_subset_sum_bit_unpacking_prod_ones192_column - 1;
    assert_range_u128_from_u256(x);
    
    // Offset must be nonnegative.
     x = dynamic_params.ec_op_ec_subset_sum_bit_unpacking_prod_ones192_offset;
    assert_range_u128_from_u256(x);
    
    // Offset must be smaller than trace length.
     x = trace_length -
        dynamic_params.ec_op_ec_subset_sum_bit_unpacking_prod_ones192_offset - 1;
    assert_range_u128_from_u256(x);
    
    // Column index out of range.
     x = dynamic_params.keccak_keccak_parse_to_diluted_reshaped_intermediate_column;
    assert_range_u128_from_u256(x);
    
    // Column index out of range.
     x = dynamic_params.num_columns_first -
        dynamic_params.keccak_keccak_parse_to_diluted_reshaped_intermediate_column - 1;
    assert_range_u128_from_u256(x);
    
    // Offset must be nonnegative.
     x = dynamic_params.keccak_keccak_parse_to_diluted_reshaped_intermediate_offset;
    assert_range_u128_from_u256(x);
    
    // Offset must be smaller than trace length.
     x = trace_length -
        dynamic_params.keccak_keccak_parse_to_diluted_reshaped_intermediate_offset - 1;
    assert_range_u128_from_u256(x);
    
    // Column index out of range.
     x = dynamic_params.keccak_keccak_parse_to_diluted_final_reshaped_input_column;
    assert_range_u128_from_u256(x);
    
    // Column index out of range.
     x = dynamic_params.num_columns_first -
        dynamic_params.keccak_keccak_parse_to_diluted_final_reshaped_input_column - 1;
    assert_range_u128_from_u256(x);
    
    // Offset must be nonnegative.
     x = dynamic_params.keccak_keccak_parse_to_diluted_final_reshaped_input_offset;
    assert_range_u128_from_u256(x);
    
    // Offset must be smaller than trace length.
     x = trace_length -
        dynamic_params.keccak_keccak_parse_to_diluted_final_reshaped_input_offset - 1;
    assert_range_u128_from_u256(x);
    
    // Column index out of range.
     x = dynamic_params.keccak_keccak_parse_to_diluted_cumulative_sum_column;
    assert_range_u128_from_u256(x);
    
    // Column index out of range.
     x = dynamic_params.num_columns_first -
        dynamic_params.keccak_keccak_parse_to_diluted_cumulative_sum_column - 1;
    assert_range_u128_from_u256(x);
    
    // Offset must be nonnegative.
     x = dynamic_params.keccak_keccak_parse_to_diluted_cumulative_sum_offset;
    assert_range_u128_from_u256(x);
    
    // Offset must be smaller than trace length.
     x = trace_length -
        dynamic_params.keccak_keccak_parse_to_diluted_cumulative_sum_offset - 1;
    assert_range_u128_from_u256(x);
    
    // Column index out of range.
     x = dynamic_params.keccak_keccak_rotated_parity0_column;
    assert_range_u128_from_u256(x);
    
    // Column index out of range.
     x = dynamic_params.num_columns_first -
        dynamic_params.keccak_keccak_rotated_parity0_column - 1;
    assert_range_u128_from_u256(x);
    
    // Offset must be nonnegative.
     x = dynamic_params.keccak_keccak_rotated_parity0_offset;
    assert_range_u128_from_u256(x);
    
    // Offset must be smaller than trace length.
     x = trace_length - dynamic_params.keccak_keccak_rotated_parity0_offset - 1;
    assert_range_u128_from_u256(x);
    
    // Column index out of range.
     x = dynamic_params.keccak_keccak_rotated_parity1_column;
    assert_range_u128_from_u256(x);
    
    // Column index out of range.
     x = dynamic_params.num_columns_first -
        dynamic_params.keccak_keccak_rotated_parity1_column - 1;
    assert_range_u128_from_u256(x);
    
    // Offset must be nonnegative.
     x = dynamic_params.keccak_keccak_rotated_parity1_offset;
    assert_range_u128_from_u256(x);
    
    // Offset must be smaller than trace length.
     x = trace_length - dynamic_params.keccak_keccak_rotated_parity1_offset - 1;
    assert_range_u128_from_u256(x);
    
    // Column index out of range.
     x = dynamic_params.keccak_keccak_rotated_parity2_column;
    assert_range_u128_from_u256(x);
    
    // Column index out of range.
     x = dynamic_params.num_columns_first -
        dynamic_params.keccak_keccak_rotated_parity2_column - 1;
    assert_range_u128_from_u256(x);
    
    // Offset must be nonnegative.
     x = dynamic_params.keccak_keccak_rotated_parity2_offset;
    assert_range_u128_from_u256(x);
    
    // Offset must be smaller than trace length.
     x = trace_length - dynamic_params.keccak_keccak_rotated_parity2_offset - 1;
    assert_range_u128_from_u256(x);
    
    // Column index out of range.
     x = dynamic_params.keccak_keccak_rotated_parity3_column;
    assert_range_u128_from_u256(x);
    
    // Column index out of range.
     x = dynamic_params.num_columns_first -
        dynamic_params.keccak_keccak_rotated_parity3_column - 1;
    assert_range_u128_from_u256(x);
    
    // Offset must be nonnegative.
     x = dynamic_params.keccak_keccak_rotated_parity3_offset;
    assert_range_u128_from_u256(x);
    
    // Offset must be smaller than trace length.
     x = trace_length - dynamic_params.keccak_keccak_rotated_parity3_offset - 1;
    assert_range_u128_from_u256(x);
    
    // Column index out of range.
     x = dynamic_params.keccak_keccak_rotated_parity4_column;
    assert_range_u128_from_u256(x);
    
    // Column index out of range.
     x = dynamic_params.num_columns_first -
        dynamic_params.keccak_keccak_rotated_parity4_column - 1;
    assert_range_u128_from_u256(x);
    
    // Offset must be nonnegative.
     x = dynamic_params.keccak_keccak_rotated_parity4_offset;
    assert_range_u128_from_u256(x);
    
    // Offset must be smaller than trace length.
     x = trace_length - dynamic_params.keccak_keccak_rotated_parity4_offset - 1;
    assert_range_u128_from_u256(x);
    
    // Column index out of range.
     x = dynamic_params.poseidon_poseidon_full_rounds_state0_column;
    assert_range_u128_from_u256(x);
    
    // Column index out of range.
     x = dynamic_params.num_columns_first -
        dynamic_params.poseidon_poseidon_full_rounds_state0_column - 1;
    assert_range_u128_from_u256(x);
    
    // Offset must be nonnegative.
     x = dynamic_params.poseidon_poseidon_full_rounds_state0_offset;
    assert_range_u128_from_u256(x);
    
    // Offset must be smaller than trace length.
     x = trace_length - dynamic_params.poseidon_poseidon_full_rounds_state0_offset - 1;
    assert_range_u128_from_u256(x);
    
    // Column index out of range.
     x = dynamic_params.poseidon_poseidon_full_rounds_state1_column;
    assert_range_u128_from_u256(x);
    
    // Column index out of range.
     x = dynamic_params.num_columns_first -
        dynamic_params.poseidon_poseidon_full_rounds_state1_column - 1;
    assert_range_u128_from_u256(x);
    
    // Offset must be nonnegative.
     x = dynamic_params.poseidon_poseidon_full_rounds_state1_offset;
    assert_range_u128_from_u256(x);
    
    // Offset must be smaller than trace length.
     x = trace_length - dynamic_params.poseidon_poseidon_full_rounds_state1_offset - 1;
    assert_range_u128_from_u256(x);
    
    // Column index out of range.
     x = dynamic_params.poseidon_poseidon_full_rounds_state2_column;
    assert_range_u128_from_u256(x);
    
    // Column index out of range.
     x = dynamic_params.num_columns_first -
        dynamic_params.poseidon_poseidon_full_rounds_state2_column - 1;
    assert_range_u128_from_u256(x);
    
    // Offset must be nonnegative.
     x = dynamic_params.poseidon_poseidon_full_rounds_state2_offset;
    assert_range_u128_from_u256(x);
    
    // Offset must be smaller than trace length.
     x = trace_length - dynamic_params.poseidon_poseidon_full_rounds_state2_offset - 1;
    assert_range_u128_from_u256(x);
    
    // Column index out of range.
     x = dynamic_params.poseidon_poseidon_full_rounds_state0_squared_column;
    assert_range_u128_from_u256(x);
    
    // Column index out of range.
     x = dynamic_params.num_columns_first -
        dynamic_params.poseidon_poseidon_full_rounds_state0_squared_column - 1;
    assert_range_u128_from_u256(x);
    
    // Offset must be nonnegative.
     x = dynamic_params.poseidon_poseidon_full_rounds_state0_squared_offset;
    assert_range_u128_from_u256(x);
    
    // Offset must be smaller than trace length.
     x = trace_length -
        dynamic_params.poseidon_poseidon_full_rounds_state0_squared_offset - 1;
    assert_range_u128_from_u256(x);
    
    // Column index out of range.
     x = dynamic_params.poseidon_poseidon_full_rounds_state1_squared_column;
    assert_range_u128_from_u256(x);
    
    // Column index out of range.
     x = dynamic_params.num_columns_first -
        dynamic_params.poseidon_poseidon_full_rounds_state1_squared_column - 1;
    assert_range_u128_from_u256(x);
    
    // Offset must be nonnegative.
     x = dynamic_params.poseidon_poseidon_full_rounds_state1_squared_offset;
    assert_range_u128_from_u256(x);
    
    // Offset must be smaller than trace length.
     x = trace_length -
        dynamic_params.poseidon_poseidon_full_rounds_state1_squared_offset - 1;
    assert_range_u128_from_u256(x);
    
    // Column index out of range.
     x = dynamic_params.poseidon_poseidon_full_rounds_state2_squared_column;
    assert_range_u128_from_u256(x);
    
    // Column index out of range.
     x = dynamic_params.num_columns_first -
        dynamic_params.poseidon_poseidon_full_rounds_state2_squared_column - 1;
    assert_range_u128_from_u256(x);
    
    // Offset must be nonnegative.
     x = dynamic_params.poseidon_poseidon_full_rounds_state2_squared_offset;
    assert_range_u128_from_u256(x);
    
    // Offset must be smaller than trace length.
     x = trace_length -
        dynamic_params.poseidon_poseidon_full_rounds_state2_squared_offset - 1;
    assert_range_u128_from_u256(x);
    
    // Column index out of range.
     x = dynamic_params.poseidon_poseidon_partial_rounds_state0_column;
    assert_range_u128_from_u256(x);
    
    // Column index out of range.
     x = dynamic_params.num_columns_first -
        dynamic_params.poseidon_poseidon_partial_rounds_state0_column - 1;
    assert_range_u128_from_u256(x);
    
    // Offset must be nonnegative.
     x = dynamic_params.poseidon_poseidon_partial_rounds_state0_offset;
    assert_range_u128_from_u256(x);
    
    // Offset must be smaller than trace length.
     x = trace_length - dynamic_params.poseidon_poseidon_partial_rounds_state0_offset - 1;
    assert_range_u128_from_u256(x);
    
    // Column index out of range.
     x = dynamic_params.poseidon_poseidon_partial_rounds_state1_column;
    assert_range_u128_from_u256(x);
    
    // Column index out of range.
     x = dynamic_params.num_columns_first -
        dynamic_params.poseidon_poseidon_partial_rounds_state1_column - 1;
    assert_range_u128_from_u256(x);
    
    // Offset must be nonnegative.
     x = dynamic_params.poseidon_poseidon_partial_rounds_state1_offset;
    assert_range_u128_from_u256(x);
    
    // Offset must be smaller than trace length.
     x = trace_length - dynamic_params.poseidon_poseidon_partial_rounds_state1_offset - 1;
    assert_range_u128_from_u256(x);
    
    // Column index out of range.
     x = dynamic_params.poseidon_poseidon_partial_rounds_state0_squared_column;
    assert_range_u128_from_u256(x);
    
    // Column index out of range.
     x = dynamic_params.num_columns_first -
        dynamic_params.poseidon_poseidon_partial_rounds_state0_squared_column - 1;
    assert_range_u128_from_u256(x);
    
    // Offset must be nonnegative.
     x = dynamic_params.poseidon_poseidon_partial_rounds_state0_squared_offset;
    assert_range_u128_from_u256(x);
    
    // Offset must be smaller than trace length.
     x = trace_length -
        dynamic_params.poseidon_poseidon_partial_rounds_state0_squared_offset - 1;
    assert_range_u128_from_u256(x);
    
    // Column index out of range.
     x = dynamic_params.poseidon_poseidon_partial_rounds_state1_squared_column;
    assert_range_u128_from_u256(x);
    
    // Column index out of range.
     x = dynamic_params.num_columns_first -
        dynamic_params.poseidon_poseidon_partial_rounds_state1_squared_column - 1;
    assert_range_u128_from_u256(x);
    
    // Offset must be nonnegative.
     x = dynamic_params.poseidon_poseidon_partial_rounds_state1_squared_offset;
    assert_range_u128_from_u256(x);
    
    // Offset must be smaller than trace length.
     x = trace_length -
        dynamic_params.poseidon_poseidon_partial_rounds_state1_squared_offset - 1;
    assert_range_u128_from_u256(x);
    
    // Column index out of range.
     x = dynamic_params.add_mod_sub_p_bit_column;
    assert_range_u128_from_u256(x);
    
    // Column index out of range.
     x = dynamic_params.num_columns_first - dynamic_params.add_mod_sub_p_bit_column - 1;
    assert_range_u128_from_u256(x);
    
    // Offset must be nonnegative.
     x = dynamic_params.add_mod_sub_p_bit_offset;
    assert_range_u128_from_u256(x);
    
    // Offset must be smaller than trace length.
     x = trace_length - dynamic_params.add_mod_sub_p_bit_offset - 1;
    assert_range_u128_from_u256(x);
    
    // Column index out of range.
     x = dynamic_params.add_mod_carry1_bit_column;
    assert_range_u128_from_u256(x);
    
    // Column index out of range.
     x = dynamic_params.num_columns_first - dynamic_params.add_mod_carry1_bit_column - 1;
    assert_range_u128_from_u256(x);
    
    // Offset must be nonnegative.
     x = dynamic_params.add_mod_carry1_bit_offset;
    assert_range_u128_from_u256(x);
    
    // Offset must be smaller than trace length.
     x = trace_length - dynamic_params.add_mod_carry1_bit_offset - 1;
    assert_range_u128_from_u256(x);
    
    // Column index out of range.
     x = dynamic_params.add_mod_carry2_bit_column;
    assert_range_u128_from_u256(x);
    
    // Column index out of range.
     x = dynamic_params.num_columns_first - dynamic_params.add_mod_carry2_bit_column - 1;
    assert_range_u128_from_u256(x);
    
    // Offset must be nonnegative.
     x = dynamic_params.add_mod_carry2_bit_offset;
    assert_range_u128_from_u256(x);
    
    // Offset must be smaller than trace length.
     x = trace_length - dynamic_params.add_mod_carry2_bit_offset - 1;
    assert_range_u128_from_u256(x);
    
    // Column index out of range.
     x = dynamic_params.add_mod_carry3_bit_column;
    assert_range_u128_from_u256(x);
    
    // Column index out of range.
     x = dynamic_params.num_columns_first - dynamic_params.add_mod_carry3_bit_column - 1;
    assert_range_u128_from_u256(x);
    
    // Offset must be nonnegative.
     x = dynamic_params.add_mod_carry3_bit_offset;
    assert_range_u128_from_u256(x);
    
    // Offset must be smaller than trace length.
     x = trace_length - dynamic_params.add_mod_carry3_bit_offset - 1;
    assert_range_u128_from_u256(x);
    
    // Column index out of range.
     x = dynamic_params.add_mod_carry1_sign_column;
    assert_range_u128_from_u256(x);
    
    // Column index out of range.
     x = dynamic_params.num_columns_first - dynamic_params.add_mod_carry1_sign_column - 1;
    assert_range_u128_from_u256(x);
    
    // Offset must be nonnegative.
     x = dynamic_params.add_mod_carry1_sign_offset;
    assert_range_u128_from_u256(x);
    
    // Offset must be smaller than trace length.
     x = trace_length - dynamic_params.add_mod_carry1_sign_offset - 1;
    assert_range_u128_from_u256(x);
    
    // Column index out of range.
     x = dynamic_params.add_mod_carry2_sign_column;
    assert_range_u128_from_u256(x);
    
    // Column index out of range.
     x = dynamic_params.num_columns_first - dynamic_params.add_mod_carry2_sign_column - 1;
    assert_range_u128_from_u256(x);
    
    // Offset must be nonnegative.
     x = dynamic_params.add_mod_carry2_sign_offset;
    assert_range_u128_from_u256(x);
    
    // Offset must be smaller than trace length.
     x = trace_length - dynamic_params.add_mod_carry2_sign_offset - 1;
    assert_range_u128_from_u256(x);
    
    // Column index out of range.
     x = dynamic_params.add_mod_carry3_sign_column;
    assert_range_u128_from_u256(x);
    
    // Column index out of range.
     x = dynamic_params.num_columns_first - dynamic_params.add_mod_carry3_sign_column - 1;
    assert_range_u128_from_u256(x);
    
    // Offset must be nonnegative.
     x = dynamic_params.add_mod_carry3_sign_offset;
    assert_range_u128_from_u256(x);
    
    // Offset must be smaller than trace length.
     x = trace_length - dynamic_params.add_mod_carry3_sign_offset - 1;
    assert_range_u128_from_u256(x);
    
    // Column index out of range.
     x = dynamic_params.memory_multi_column_perm_perm_cum_prod0_column -
        dynamic_params.num_columns_first;
    assert_range_u128_from_u256(x);
    
    // Column index out of range.
     x = dynamic_params.num_columns_first + dynamic_params.num_columns_second -
        dynamic_params.memory_multi_column_perm_perm_cum_prod0_column - 1;
    assert_range_u128_from_u256(x);
    
    // Offset must be nonnegative.
     x = dynamic_params.memory_multi_column_perm_perm_cum_prod0_offset;
    assert_range_u128_from_u256(x);
    
    // Offset must be smaller than trace length.
     x = trace_length - dynamic_params.memory_multi_column_perm_perm_cum_prod0_offset - 1;
    assert_range_u128_from_u256(x);
    
    // Column index out of range.
     x = dynamic_params.range_check16_perm_cum_prod0_column -
        dynamic_params.num_columns_first;
    assert_range_u128_from_u256(x);
    
    // Column index out of range.
     x = dynamic_params.num_columns_first + dynamic_params.num_columns_second -
        dynamic_params.range_check16_perm_cum_prod0_column - 1;
    assert_range_u128_from_u256(x);
    
    // Offset must be nonnegative.
     x = dynamic_params.range_check16_perm_cum_prod0_offset;
    assert_range_u128_from_u256(x);
    
    // Offset must be smaller than trace length.
     x = trace_length - dynamic_params.range_check16_perm_cum_prod0_offset - 1;
    assert_range_u128_from_u256(x);
    
    // Column index out of range.
     x = dynamic_params.diluted_check_cumulative_value_column -
        dynamic_params.num_columns_first;
    assert_range_u128_from_u256(x);
    
    // Column index out of range.
     x = dynamic_params.num_columns_first + dynamic_params.num_columns_second -
        dynamic_params.diluted_check_cumulative_value_column - 1;
    assert_range_u128_from_u256(x);
    
    // Offset must be nonnegative.
     x = dynamic_params.diluted_check_cumulative_value_offset;
    assert_range_u128_from_u256(x);
    
    // Offset must be smaller than trace length.
     x = trace_length - dynamic_params.diluted_check_cumulative_value_offset - 1;
    assert_range_u128_from_u256(x);
    
    // Column index out of range.
     x = dynamic_params.diluted_check_permutation_cum_prod0_column -
        dynamic_params.num_columns_first;
    assert_range_u128_from_u256(x);
    
    // Column index out of range.
     x = dynamic_params.num_columns_first + dynamic_params.num_columns_second -
        dynamic_params.diluted_check_permutation_cum_prod0_column - 1;
    assert_range_u128_from_u256(x);
    
    // Offset must be nonnegative.
     x = dynamic_params.diluted_check_permutation_cum_prod0_offset;
    assert_range_u128_from_u256(x);
    
    // Offset must be smaller than trace length.
     x = trace_length - dynamic_params.diluted_check_permutation_cum_prod0_offset - 1;
    assert_range_u128_from_u256(x);
    

    if (dynamic_params.uses_pedersen_builtin != 0) {
         
        // Row ratio should be a power of 2, smaller than trace length.
         x = dynamic_params.pedersen_builtin_row_ratio;
        assert_is_power_of_2(x.into());
        // Dimension should be a power of 2.
         x = (trace_length /  dynamic_params.pedersen_builtin_row_ratio);
        assert_is_power_of_2(x.into());
        // Coset step ((dynamicparam(pedersen_builtin_row_ratio)) / (512)) must be a power of two.
         x = dynamic_params.pedersen_builtin_row_ratio / 512;
        assert_is_power_of_2(x.into());
        // Coset step ((dynamicparam(pedersen_builtin_row_ratio)) / (2)) must be a power of two.
         x = dynamic_params.pedersen_builtin_row_ratio / 2;
        assert_is_power_of_2(x.into());
        // Step must not exceed dimension.
         x = (trace_length /  dynamic_params.pedersen_builtin_row_ratio) - 1;
        assert_range_u128_from_u256(x);
        
        // Index should be non negative.
         x = (trace_length /  dynamic_params.pedersen_builtin_row_ratio);
        assert_range_u128_from_u256(x);
        
        // Coset step (memberexpression(trace_length)) must be a power of two.
         x = trace_length;
        assert_is_power_of_2(x.into());
        // Offset of pedersen/input0 must be nonnegative.
         x = dynamic_params.pedersen_input0_suboffset;
        assert_range_u128_from_u256(x);
        
        // Offset of pedersen/input0 is too big.
         x = trace_length - dynamic_params.pedersen_input0_suboffset - 1;
        assert_range_u128_from_u256(x);
        
        // Offset of pedersen/input0 is too big.
         x = dynamic_params.pedersen_builtin_row_ratio  - 
                dynamic_params.pedersen_input0_suboffset * dynamic_params.memory_units_row_ratio
             -  1
        assert_range_u128_from_u256(x);
        
        // Offset of pedersen/input1 must be nonnegative.
         x = dynamic_params.pedersen_input1_suboffset;
        assert_range_u128_from_u256(x);
        
        // Offset of pedersen/input1 is too big.
         x = trace_length - dynamic_params.pedersen_input1_suboffset - 1;
        assert_range_u128_from_u256(x);
        
        // Offset of pedersen/input1 is too big.
         x = dynamic_params.pedersen_builtin_row_ratio  - 
                dynamic_params.pedersen_input1_suboffset * dynamic_params.memory_units_row_ratio
             -  1
        assert_range_u128_from_u256(x);
        
        // Offset of pedersen/output must be nonnegative.
         x = dynamic_params.pedersen_output_suboffset;
        assert_range_u128_from_u256(x);
        
        // Offset of pedersen/output is too big.
         x = trace_length - dynamic_params.pedersen_output_suboffset - 1;
        assert_range_u128_from_u256(x);
        
        // Offset of pedersen/output is too big.
         x = dynamic_params.pedersen_builtin_row_ratio  - 
                dynamic_params.pedersen_output_suboffset * dynamic_params.memory_units_row_ratio
             -  1
        assert_range_u128_from_u256(x);
        

         
    }

    if (dynamic_params.uses_range_check_builtin != 0) {
         
        // Coset step (memberexpression(trace_length)) must be a power of two.
         x = trace_length;
        assert_is_power_of_2(x.into());
        // Row ratio should be a power of 2, smaller than trace length.
         x = dynamic_params.range_check_builtin_row_ratio;
        assert_is_power_of_2(x.into());
        // Dimension should be a power of 2.
         x = (trace_length /  dynamic_params.range_check_builtin_row_ratio);
        assert_is_power_of_2(x.into());
        // Step must not exceed dimension.
         x = (trace_length /  dynamic_params.range_check_builtin_row_ratio) - 1;
        assert_range_u128_from_u256(x);
        
        // Index should be non negative.
         x = (trace_length /  dynamic_params.range_check_builtin_row_ratio);
        assert_range_u128_from_u256(x);
        
        // Coset step ((dynamicparam(range_check_builtin_row_ratio)) / (8)) must be a power of two.
         x = dynamic_params.range_check_builtin_row_ratio / 8;
        assert_is_power_of_2(x.into());
        // Offset of range_check_builtin/mem must be nonnegative.
         x = dynamic_params.range_check_builtin_mem_suboffset;
        assert_range_u128_from_u256(x);
        
        // Offset of range_check_builtin/mem is too big.
         x = trace_length - dynamic_params.range_check_builtin_mem_suboffset - 1;
        assert_range_u128_from_u256(x);
        
        // Offset of range_check_builtin/mem is too big.
         x = dynamic_params.range_check_builtin_row_ratio - dynamic_params.range_check_builtin_mem_suboffset * dynamic_params.memory_units_row_ratio - 1;
        assert_range_u128_from_u256(x);
        
        // Offset of range_check_builtin/inner_range_check must be nonnegative.
         x = dynamic_params.range_check_builtin_inner_range_check_suboffset;
        assert_range_u128_from_u256(x);
        
        // Offset of range_check_builtin/inner_range_check is too big.
         x = trace_length - dynamic_params.range_check_builtin_inner_range_check_suboffset -
            1;
        assert_range_u128_from_u256(x);
        
        // Offset of range_check_builtin/inner_range_check is too big.
         x = dynamic_params.range_check_builtin_row_ratio / 8 - dynamic_params.range_check_builtin_inner_range_check_suboffset * dynamic_params.range_check_units_row_ratio - 1;
        assert_range_u128_from_u256(x);
         
    }

    if (dynamic_params.uses_ecdsa_builtin != 0) {
         
        // Row ratio should be a power of 2, smaller than trace length.
         x = dynamic_params.ecdsa_builtin_row_ratio;
        assert_is_power_of_2(x.into());
        // Dimension should be a power of 2.
         x = (trace_length /  dynamic_params.ecdsa_builtin_row_ratio);
        assert_is_power_of_2(x.into());
        // Coset step ((dynamicparam(ecdsa_builtin_row_ratio)) / (512)) must be a power of two.
         x = dynamic_params.ecdsa_builtin_row_ratio / 512;
        assert_is_power_of_2(x.into());
        // Step must not exceed dimension.
         x = (trace_length /  dynamic_params.ecdsa_builtin_row_ratio) - 1;
        assert_range_u128_from_u256(x);
        
        // Index should be non negative.
         x = (trace_length /  dynamic_params.ecdsa_builtin_row_ratio);
        assert_range_u128_from_u256(x);
        
        // Coset step ((dynamicparam(ecdsa_builtin_row_ratio)) / (256)) must be a power of two.
         x = dynamic_params.ecdsa_builtin_row_ratio / 256;
        assert_is_power_of_2(x.into());
        // Coset step (memberexpression(trace_length)) must be a power of two.
         x = trace_length;
        assert_is_power_of_2(x.into());
        // Coset step ((dynamicparam(ecdsa_builtin_row_ratio)) / (2)) must be a power of two.
         x = dynamic_params.ecdsa_builtin_row_ratio / 2;
        assert_is_power_of_2(x.into());
        // Offset of ecdsa/pubkey must be nonnegative.
         x = dynamic_params.ecdsa_pubkey_suboffset;
        assert_range_u128_from_u256(x);
        
        // Offset of ecdsa/pubkey is too big.
         x = trace_length - dynamic_params.ecdsa_pubkey_suboffset - 1;
        assert_range_u128_from_u256(x);
        
        // Offset of ecdsa/pubkey is too big.
         x = dynamic_params.ecdsa_builtin_row_ratio - dynamic_params.ecdsa_pubkey_suboffset * dynamic_params.memory_units_row_ratio - 1;
        assert_range_u128_from_u256(x);
        
        // Offset of ecdsa/message must be nonnegative.
         x = dynamic_params.ecdsa_message_suboffset;
        assert_range_u128_from_u256(x);
        
        // Offset of ecdsa/message is too big.
         x = trace_length - dynamic_params.ecdsa_message_suboffset - 1;
        assert_range_u128_from_u256(x);
        
        // Offset of ecdsa/message is too big.
         x = dynamic_params.ecdsa_builtin_row_ratio - dynamic_params.ecdsa_message_suboffset * dynamic_params.memory_units_row_ratio - 1;
        assert_range_u128_from_u256(x);
    }

    if (dynamic_params.uses_bitwise_builtin != 0) {
         
        // Row ratio should be a power of 2, smaller than trace length.
         x = dynamic_params.bitwise_row_ratio;
        assert_is_power_of_2(x.into());
        // Dimension should be a power of 2.
         x = (trace_length /  dynamic_params.bitwise_row_ratio);
        assert_is_power_of_2(x.into());
        // Coset step ((dynamicparam(bitwise_row_ratio)) / (64)) must be a power of two.
         x = dynamic_params.bitwise_row_ratio / 64;
        assert_is_power_of_2(x.into());
        // Coset step ((dynamicparam(bitwise_row_ratio)) / (4)) must be a power of two.
         x = dynamic_params.bitwise_row_ratio / 4;
        assert_is_power_of_2(x.into());
        // Index out of range.
         x = trace_length /  dynamic_params.bitwise_row_ratio - 1;
        assert_range_u128_from_u256(x);
        
        // Index should be non negative.
         x = (trace_length /  dynamic_params.bitwise_row_ratio);
        assert_range_u128_from_u256(x);
        
        // Coset step (memberexpression(trace_length)) must be a power of two.
         x = trace_length;
        assert_is_power_of_2(x.into());
        // Offset of bitwise/var_pool must be nonnegative.
         x = dynamic_params.bitwise_var_pool_suboffset;
        assert_range_u128_from_u256(x);
        
        // Offset of bitwise/var_pool is too big.
         x = trace_length - dynamic_params.bitwise_var_pool_suboffset - 1;
        assert_range_u128_from_u256(x);
        
        // Offset of bitwise/var_pool is too big.
         x = dynamic_params.bitwise_row_ratio / 4 - dynamic_params.bitwise_var_pool_suboffset * dynamic_params.memory_units_row_ratio - 1;
        assert_range_u128_from_u256(x);
        
        // Offset of bitwise/x_or_y must be nonnegative.
         x = dynamic_params.bitwise_x_or_y_suboffset;
        assert_range_u128_from_u256(x);
        
        // Offset of bitwise/x_or_y is too big.
         x = trace_length - dynamic_params.bitwise_x_or_y_suboffset - 1;
        assert_range_u128_from_u256(x);
        
        // Offset of bitwise/x_or_y is too big.
         x = dynamic_params.bitwise_row_ratio - dynamic_params.bitwise_x_or_y_suboffset * dynamic_params.memory_units_row_ratio - 1;
        assert_range_u128_from_u256(x);
        
        // Offset of bitwise/diluted_var_pool must be nonnegative.
         x = dynamic_params.bitwise_diluted_var_pool_suboffset;
        assert_range_u128_from_u256(x);
        
        // Offset of bitwise/diluted_var_pool is too big.
         x = trace_length - dynamic_params.bitwise_diluted_var_pool_suboffset - 1;
        assert_range_u128_from_u256(x);
        
        // Offset of bitwise/diluted_var_pool is too big.
         x = dynamic_params.bitwise_row_ratio / 64 - dynamic_params.bitwise_diluted_var_pool_suboffset * dynamic_params.diluted_units_row_ratio - 1;
        assert_range_u128_from_u256(x);
        
        // Offset of bitwise/trim_unpacking192 must be nonnegative.
         x = dynamic_params.bitwise_trim_unpacking192_suboffset;
        assert_range_u128_from_u256(x);
        
        // Offset of bitwise/trim_unpacking192 is too big.
         x = trace_length - dynamic_params.bitwise_trim_unpacking192_suboffset - 1;
        assert_range_u128_from_u256(x);
        
        // Offset of bitwise/trim_unpacking192 is too big.
         x = dynamic_params.bitwise_row_ratio - dynamic_params.bitwise_trim_unpacking192_suboffset * dynamic_params.diluted_units_row_ratio - 1;
        assert_range_u128_from_u256(x);
        
        // Offset of bitwise/trim_unpacking193 must be nonnegative.
         x = dynamic_params.bitwise_trim_unpacking193_suboffset;
        assert_range_u128_from_u256(x);
        
        // Offset of bitwise/trim_unpacking193 is too big.
         x = trace_length - dynamic_params.bitwise_trim_unpacking193_suboffset - 1;
        assert_range_u128_from_u256(x);
        
        // Offset of bitwise/trim_unpacking193 is too big.
         x = dynamic_params.bitwise_row_ratio - dynamic_params.bitwise_trim_unpacking193_suboffset * dynamic_params.diluted_units_row_ratio - 1;
        assert_range_u128_from_u256(x);
        
        // Offset of bitwise/trim_unpacking194 must be nonnegative.
         x = dynamic_params.bitwise_trim_unpacking194_suboffset;
        assert_range_u128_from_u256(x);
        
        // Offset of bitwise/trim_unpacking194 is too big.
         x = trace_length - dynamic_params.bitwise_trim_unpacking194_suboffset - 1;
        assert_range_u128_from_u256(x);
        
        // Offset of bitwise/trim_unpacking194 is too big.
         x = dynamic_params.bitwise_row_ratio - dynamic_params.bitwise_trim_unpacking194_suboffset * dynamic_params.diluted_units_row_ratio - 1;
        assert_range_u128_from_u256(x);
        
        // Offset of bitwise/trim_unpacking195 must be nonnegative.
         x = dynamic_params.bitwise_trim_unpacking195_suboffset;
        assert_range_u128_from_u256(x);
        
        // Offset of bitwise/trim_unpacking195 is too big.
         x = trace_length - dynamic_params.bitwise_trim_unpacking195_suboffset - 1;
        assert_range_u128_from_u256(x);
        
        // Offset of bitwise/trim_unpacking195 is too big.
         x = dynamic_params.bitwise_row_ratio - dynamic_params.bitwise_trim_unpacking195_suboffset * dynamic_params.diluted_units_row_ratio - 1;
        assert_range_u128_from_u256(x);
    }

    if (dynamic_params.uses_ec_op_builtin != 0) {
         
        // Row ratio should be a power of 2, smaller than trace length.
         x = dynamic_params.ec_op_builtin_row_ratio;
        assert_is_power_of_2(x.into());
        // Dimension should be a power of 2.
         x = (trace_length /  dynamic_params.ec_op_builtin_row_ratio);
        assert_is_power_of_2(x.into());
        // Coset step ((dynamicparam(ec_op_builtin_row_ratio)) / (256)) must be a power of two.
         x = dynamic_params.ec_op_builtin_row_ratio / 256;
        assert_is_power_of_2(x.into());
        // Index out of range.
         x = (trace_length /  dynamic_params.ec_op_builtin_row_ratio) - 1;
        assert_range_u128_from_u256(x);
        
        // Index should be non negative.
         x = (trace_length /  dynamic_params.ec_op_builtin_row_ratio);
        assert_range_u128_from_u256(x);
        
        // Coset step (memberexpression(trace_length)) must be a power of two.
         x = trace_length;
        assert_is_power_of_2(x.into());
        // Offset of ec_op/p_x must be nonnegative.
         x = dynamic_params.ec_op_p_x_suboffset;
        assert_range_u128_from_u256(x);
        
        // Offset of ec_op/p_x is too big.
         x = trace_length - dynamic_params.ec_op_p_x_suboffset - 1;
        assert_range_u128_from_u256(x);
        
        // Offset of ec_op/p_x is too big.
         x = dynamic_params.ec_op_builtin_row_ratio - dynamic_params.ec_op_p_x_suboffset * dynamic_params.memory_units_row_ratio - 1;
        assert_range_u128_from_u256(x);
        
        // Offset of ec_op/p_y must be nonnegative.
         x = dynamic_params.ec_op_p_y_suboffset;
        assert_range_u128_from_u256(x);
        
        // Offset of ec_op/p_y is too big.
         x = trace_length - dynamic_params.ec_op_p_y_suboffset - 1;
        assert_range_u128_from_u256(x);
        
        // Offset of ec_op/p_y is too big.
         x = dynamic_params.ec_op_builtin_row_ratio - dynamic_params.ec_op_p_y_suboffset * dynamic_params.memory_units_row_ratio - 1;
        assert_range_u128_from_u256(x);
        
        // Offset of ec_op/q_x must be nonnegative.
         x = dynamic_params.ec_op_q_x_suboffset;
        assert_range_u128_from_u256(x);
        
        // Offset of ec_op/q_x is too big.
         x = trace_length - dynamic_params.ec_op_q_x_suboffset - 1;
        assert_range_u128_from_u256(x);
        
        // Offset of ec_op/q_x is too big.
         x = dynamic_params.ec_op_builtin_row_ratio - dynamic_params.ec_op_q_x_suboffset * dynamic_params.memory_units_row_ratio - 1;
        assert_range_u128_from_u256(x);
        
        // Offset of ec_op/q_y must be nonnegative.
         x = dynamic_params.ec_op_q_y_suboffset;
        assert_range_u128_from_u256(x);
        
        // Offset of ec_op/q_y is too big.
         x = trace_length - dynamic_params.ec_op_q_y_suboffset - 1;
        assert_range_u128_from_u256(x);
        
        // Offset of ec_op/q_y is too big.
         x = dynamic_params.ec_op_builtin_row_ratio - dynamic_params.ec_op_q_y_suboffset * dynamic_params.memory_units_row_ratio - 1;
        assert_range_u128_from_u256(x);
        
        // Offset of ec_op/m must be nonnegative.
         x = dynamic_params.ec_op_m_suboffset;
        assert_range_u128_from_u256(x);
        
        // Offset of ec_op/m is too big.
         x = trace_length - dynamic_params.ec_op_m_suboffset - 1;
        assert_range_u128_from_u256(x);
        
        // Offset of ec_op/m is too big.
         x = dynamic_params.ec_op_builtin_row_ratio - dynamic_params.ec_op_m_suboffset * dynamic_params.memory_units_row_ratio - 1;
        assert_range_u128_from_u256(x);
        
        // Offset of ec_op/r_x must be nonnegative.
         x = dynamic_params.ec_op_r_x_suboffset;
        assert_range_u128_from_u256(x);
        
        // Offset of ec_op/r_x is too big.
         x = trace_length - dynamic_params.ec_op_r_x_suboffset - 1;
        assert_range_u128_from_u256(x);
        
        // Offset of ec_op/r_x is too big.
         x = dynamic_params.ec_op_builtin_row_ratio - dynamic_params.ec_op_r_x_suboffset * dynamic_params.memory_units_row_ratio - 1;
        assert_range_u128_from_u256(x);
        
        // Offset of ec_op/r_y must be nonnegative.
         x = dynamic_params.ec_op_r_y_suboffset;
        assert_range_u128_from_u256(x);
        
        // Offset of ec_op/r_y is too big.
         x = trace_length - dynamic_params.ec_op_r_y_suboffset - 1;
        assert_range_u128_from_u256(x);
        
        // Offset of ec_op/r_y is too big.
         x = dynamic_params.ec_op_builtin_row_ratio - dynamic_params.ec_op_r_y_suboffset * dynamic_params.memory_units_row_ratio - 1;
        assert_range_u128_from_u256(x);
        

         
    }

    if (dynamic_params.uses_keccak_builtin != 0) {
         
        // Coset step ((dynamicparam(keccak_row_ratio)) / (4096)) must be a power of two.
         x = dynamic_params.keccak_row_ratio / 4096;
        assert_is_power_of_2(x.into());
        // Dimension should be a power of 2.
         x = (trace_length /  (16 * dynamic_params.keccak_row_ratio));
        assert_is_power_of_2(x.into());
        // Coset step ((dynamicparam(keccak_row_ratio)) / (128)) must be a power of two.
         x = dynamic_params.keccak_row_ratio / 128;
        assert_is_power_of_2(x.into());
        // Coset step ((dynamicparam(keccak_row_ratio)) / (32768)) must be a power of two.
         x = dynamic_params.keccak_row_ratio / 32768;
        assert_is_power_of_2(x.into());
        // Row ratio should be a power of 2, smaller than trace length.
         x = dynamic_params.keccak_row_ratio;
        assert_is_power_of_2(x.into());
        // Coset step ((dynamicparam(keccak_row_ratio)) / (16)) must be a power of two.
         x = dynamic_params.keccak_row_ratio / 16;
        assert_is_power_of_2(x.into());
        // Dimension should be a power of 2.
         x = (16 * trace_length) / dynamic_params.keccak_row_ratio;
        assert_is_power_of_2(x.into());
        // Index out of range.
         x = (16 * trace_length) / dynamic_params.keccak_row_ratio - 1;
        assert_range_u128_from_u256(x);
        
        // Index should be non negative.
         x = (16 * trace_length) / dynamic_params.keccak_row_ratio;
        assert_range_u128_from_u256(x);
        
        // Coset step (memberexpression(trace_length)) must be a power of two.
         x = trace_length;
        assert_is_power_of_2(x.into());
        // Offset of keccak/input_output must be nonnegative.
         x = dynamic_params.keccak_input_output_suboffset;
        assert_range_u128_from_u256(x);
        
        // Offset of keccak/input_output is too big.
         x = trace_length - dynamic_params.keccak_input_output_suboffset - 1;
        assert_range_u128_from_u256(x);
        
        // Offset of keccak/input_output is too big.
         x = dynamic_params.keccak_row_ratio / 16 - dynamic_params.keccak_input_output_suboffset * dynamic_params.memory_units_row_ratio - 1;
        assert_range_u128_from_u256(x);
        
        // Offset of keccak/keccak/diluted_column0 must be nonnegative.
         x = dynamic_params.keccak_keccak_diluted_column0_suboffset;
        assert_range_u128_from_u256(x);
        
        // Offset of keccak/keccak/diluted_column0 is too big.
         x = trace_length - dynamic_params.keccak_keccak_diluted_column0_suboffset - 1;
        assert_range_u128_from_u256(x);
        
        // Offset of keccak/keccak/diluted_column0 is too big.
         x = dynamic_params.keccak_row_ratio / 4096 - dynamic_params.keccak_keccak_diluted_column0_suboffset * dynamic_params.diluted_units_row_ratio - 1;
        assert_range_u128_from_u256(x);
        
        // Offset of keccak/keccak/diluted_column1 must be nonnegative.
         x = dynamic_params.keccak_keccak_diluted_column1_suboffset;
        assert_range_u128_from_u256(x);
        
        // Offset of keccak/keccak/diluted_column1 is too big.
         x = trace_length - dynamic_params.keccak_keccak_diluted_column1_suboffset - 1;
        assert_range_u128_from_u256(x);
        
        // Offset of keccak/keccak/diluted_column1 is too big.
         x = dynamic_params.keccak_row_ratio / 4096 - dynamic_params.keccak_keccak_diluted_column1_suboffset * dynamic_params.diluted_units_row_ratio - 1;
        assert_range_u128_from_u256(x);
        
        // Offset of keccak/keccak/diluted_column2 must be nonnegative.
         x = dynamic_params.keccak_keccak_diluted_column2_suboffset;
        assert_range_u128_from_u256(x);
        
        // Offset of keccak/keccak/diluted_column2 is too big.
         x = trace_length - dynamic_params.keccak_keccak_diluted_column2_suboffset - 1;
        assert_range_u128_from_u256(x);
        
        // Offset of keccak/keccak/diluted_column2 is too big.
         x = dynamic_params.keccak_row_ratio / 4096 - dynamic_params.keccak_keccak_diluted_column2_suboffset * dynamic_params.diluted_units_row_ratio - 1;
        assert_range_u128_from_u256(x);
        
        // Offset of keccak/keccak/diluted_column3 must be nonnegative.
         x = dynamic_params.keccak_keccak_diluted_column3_suboffset;
        assert_range_u128_from_u256(x);
        
        // Offset of keccak/keccak/diluted_column3 is too big.
         x = trace_length - dynamic_params.keccak_keccak_diluted_column3_suboffset - 1;
        assert_range_u128_from_u256(x);
        
        // Offset of keccak/keccak/diluted_column3 is too big.
         x = dynamic_params.keccak_row_ratio / 4096 - dynamic_params.keccak_keccak_diluted_column3_suboffset * dynamic_params.diluted_units_row_ratio - 1;
        assert_range_u128_from_u256(x);
        

         
    }

    if (dynamic_params.uses_poseidon_builtin != 0) {
         
        // Row ratio should be a power of 2, smaller than trace length.
         x = dynamic_params.poseidon_row_ratio;
        assert_is_power_of_2(x.into());
        // Dimension should be a power of 2.
         x = (trace_length /  dynamic_params.poseidon_row_ratio);
        assert_is_power_of_2(x.into());
        // Coset step ((dynamicparam(poseidon_row_ratio)) / (32)) must be a power of two.
         x = dynamic_params.poseidon_row_ratio /  32;
        assert_is_power_of_2(x.into());
        // Coset step ((dynamicparam(poseidon_row_ratio)) / (8)) must be a power of two.
         x = dynamic_params.poseidon_row_ratio /  8;
        assert_is_power_of_2(x.into());
        // Coset step ((dynamicparam(poseidon_row_ratio)) / (64)) must be a power of two.
         x = dynamic_params.poseidon_row_ratio /  64;
        assert_is_power_of_2(x.into());
        // Coset step ((dynamicparam(poseidon_row_ratio)) / (2)) must be a power of two.
         x = dynamic_params.poseidon_row_ratio / 2;
        assert_is_power_of_2(x.into());
        // Dimension should be a power of 2.
         x = 2 * trace_length / dynamic_params.poseidon_row_ratio;
        assert_is_power_of_2(x.into());
        // Index out of range.
         x = 2 * trace_length / dynamic_params.poseidon_row_ratio -1;
        assert_range_u128_from_u256(x);
        
        // Index should be non negative.
         x = 2 * trace_length / dynamic_params.poseidon_row_ratio;
        assert_range_u128_from_u256(x);
        
        // Coset step (memberexpression(trace_length)) must be a power of two.
         x = trace_length;
        assert_is_power_of_2(x.into());
        // Offset of poseidon/param_0/input_output must be nonnegative.
         x = dynamic_params.poseidon_param_0_input_output_suboffset;
        assert_range_u128_from_u256(x);
        
        // Offset of poseidon/param_0/input_output is too big.
         x = trace_length - dynamic_params.poseidon_param_0_input_output_suboffset - 1;
        assert_range_u128_from_u256(x);
        
        // Offset of poseidon/param_0/input_output is too big.
         x = dynamic_params.poseidon_row_ratio / 2 - dynamic_params.poseidon_param_0_input_output_suboffset * dynamic_params.memory_units_row_ratio - 1;
        assert_range_u128_from_u256(x);
        
        // Offset of poseidon/param_1/input_output must be nonnegative.
         x = dynamic_params.poseidon_param_1_input_output_suboffset;
        assert_range_u128_from_u256(x);
        
        // Offset of poseidon/param_1/input_output is too big.
         x = trace_length - dynamic_params.poseidon_param_1_input_output_suboffset - 1;
        assert_range_u128_from_u256(x);
        
        // Offset of poseidon/param_1/input_output is too big.
         x = dynamic_params.poseidon_row_ratio / 2 - dynamic_params.poseidon_param_1_input_output_suboffset * dynamic_params.memory_units_row_ratio - 1;
        assert_range_u128_from_u256(x);
        
        // Offset of poseidon/param_2/input_output must be nonnegative.
         x = dynamic_params.poseidon_param_2_input_output_suboffset;
        assert_range_u128_from_u256(x);
        
        // Offset of poseidon/param_2/input_output is too big.
         x = trace_length - dynamic_params.poseidon_param_2_input_output_suboffset - 1;
        assert_range_u128_from_u256(x);
        
        // Offset of poseidon/param_2/input_output is too big.
         x = dynamic_params.poseidon_row_ratio / 2 - dynamic_params.poseidon_param_2_input_output_suboffset * dynamic_params.memory_units_row_ratio - 1;
        assert_range_u128_from_u256(x);
        

         
    }

    if (dynamic_params.uses_range_check96_builtin != 0) {
         
        // Coset step (memberexpression(trace_length)) must be a power of two.
         x = trace_length;
        assert_is_power_of_2(x.into());
        // Row ratio should be a power of 2, smaller than trace length.
         x = dynamic_params.range_check96_builtin_row_ratio;
        assert_is_power_of_2(x.into());
        // Dimension should be a power of 2.
         x = (trace_length /  dynamic_params.range_check96_builtin_row_ratio);
        assert_is_power_of_2(x.into());
        // Step must not exceed dimension.
         x = (trace_length /  dynamic_params.range_check96_builtin_row_ratio) - 1;
        assert_range_u128_from_u256(x);
        
        // Index should be non negative.
         x = (trace_length /  dynamic_params.range_check96_builtin_row_ratio);
        assert_range_u128_from_u256(x);
        
        // Offset of range_check96_builtin/mem must be nonnegative.
         x = dynamic_params.range_check96_builtin_mem_suboffset;
        assert_range_u128_from_u256(x);
        
        // Offset of range_check96_builtin/mem is too big.
         x = trace_length - dynamic_params.range_check96_builtin_mem_suboffset - 1;
        assert_range_u128_from_u256(x);
        
        // Offset of range_check96_builtin/mem is too big.
         x = dynamic_params.range_check96_builtin_row_ratio - dynamic_params.range_check96_builtin_mem_suboffset * dynamic_params.memory_units_row_ratio - 1;
        assert_range_u128_from_u256(x);
        
        // Offset of range_check96_builtin/inner_range_check0 must be nonnegative.
         x = dynamic_params.range_check96_builtin_inner_range_check0_suboffset;
        assert_range_u128_from_u256(x);
        
        // Offset of range_check96_builtin/inner_range_check0 is too big.
         x = trace_length -
            dynamic_params.range_check96_builtin_inner_range_check0_suboffset - 1;
        assert_range_u128_from_u256(x);
        
        // Offset of range_check96_builtin/inner_range_check0 is too big.
         x = dynamic_params.range_check96_builtin_row_ratio - dynamic_params.range_check96_builtin_inner_range_check0_suboffset * dynamic_params.range_check_units_row_ratio - 1;
        assert_range_u128_from_u256(x);
        
        // Offset of range_check96_builtin/inner_range_check1 must be nonnegative.
         x = dynamic_params.range_check96_builtin_inner_range_check1_suboffset;
        assert_range_u128_from_u256(x);
        
        // Offset of range_check96_builtin/inner_range_check1 is too big.
         x = trace_length -
            dynamic_params.range_check96_builtin_inner_range_check1_suboffset - 1;
        assert_range_u128_from_u256(x);
        
        // Offset of range_check96_builtin/inner_range_check1 is too big.
         x = dynamic_params.range_check96_builtin_row_ratio - dynamic_params.range_check96_builtin_inner_range_check1_suboffset * dynamic_params.range_check_units_row_ratio - 1;
        assert_range_u128_from_u256(x);
        
        // Offset of range_check96_builtin/inner_range_check2 must be nonnegative.
         x = dynamic_params.range_check96_builtin_inner_range_check2_suboffset;
        assert_range_u128_from_u256(x);
        
        // Offset of range_check96_builtin/inner_range_check2 is too big.
         x = trace_length -
            dynamic_params.range_check96_builtin_inner_range_check2_suboffset - 1;
        assert_range_u128_from_u256(x);
        
        // Offset of range_check96_builtin/inner_range_check2 is too big.
         x = dynamic_params.range_check96_builtin_row_ratio - dynamic_params.range_check96_builtin_inner_range_check2_suboffset * dynamic_params.range_check_units_row_ratio - 1;
        assert_range_u128_from_u256(x);
        
        // Offset of range_check96_builtin/inner_range_check3 must be nonnegative.
         x = dynamic_params.range_check96_builtin_inner_range_check3_suboffset;
        assert_range_u128_from_u256(x);
        
        // Offset of range_check96_builtin/inner_range_check3 is too big.
         x = trace_length -
            dynamic_params.range_check96_builtin_inner_range_check3_suboffset - 1;
        assert_range_u128_from_u256(x);
        
        // Offset of range_check96_builtin/inner_range_check3 is too big.
         x = dynamic_params.range_check96_builtin_row_ratio - dynamic_params.range_check96_builtin_inner_range_check3_suboffset * dynamic_params.range_check_units_row_ratio - 1;
        assert_range_u128_from_u256(x);
        
        // Offset of range_check96_builtin/inner_range_check4 must be nonnegative.
         x = dynamic_params.range_check96_builtin_inner_range_check4_suboffset;
        assert_range_u128_from_u256(x);
        
        // Offset of range_check96_builtin/inner_range_check4 is too big.
         x = trace_length -
            dynamic_params.range_check96_builtin_inner_range_check4_suboffset - 1;
        assert_range_u128_from_u256(x);
        
        // Offset of range_check96_builtin/inner_range_check4 is too big.
         x = dynamic_params.range_check96_builtin_row_ratio - dynamic_params.range_check96_builtin_inner_range_check4_suboffset * dynamic_params.range_check_units_row_ratio - 1;
        assert_range_u128_from_u256(x);
        
        // Offset of range_check96_builtin/inner_range_check5 must be nonnegative.
         x = dynamic_params.range_check96_builtin_inner_range_check5_suboffset;
        assert_range_u128_from_u256(x);
        
        // Offset of range_check96_builtin/inner_range_check5 is too big.
         x = trace_length -
            dynamic_params.range_check96_builtin_inner_range_check5_suboffset - 1;
        assert_range_u128_from_u256(x);
        
        // Offset of range_check96_builtin/inner_range_check5 is too big.
         x = dynamic_params.range_check96_builtin_row_ratio - dynamic_params.range_check96_builtin_inner_range_check5_suboffset * dynamic_params.range_check_units_row_ratio - 1;
        assert_range_u128_from_u256(x);
        

         
    }

    if (dynamic_params.uses_add_mod_builtin != 0) {
         
        // Row ratio should be a power of 2, smaller than trace length.
         x = dynamic_params.add_mod_row_ratio;
        assert_is_power_of_2(x.into());
        // Dimension should be a power of 2.
         x = (trace_length /  dynamic_params.add_mod_row_ratio);
        assert_is_power_of_2(x.into());
        // Index out of range.
         x = (trace_length /  dynamic_params.add_mod_row_ratio) - 1;
        assert_range_u128_from_u256(x);
        
        // Index should be non negative.
         x = (trace_length /  dynamic_params.add_mod_row_ratio);
        assert_range_u128_from_u256(x);
        
        // Coset step (memberexpression(trace_length)) must be a power of two.
         x = trace_length;
        assert_is_power_of_2(x.into());
        // Offset of add_mod/p0 must be nonnegative.
         x = dynamic_params.add_mod_p0_suboffset;
        assert_range_u128_from_u256(x);
        
        // Offset of add_mod/p0 is too big.
         x = trace_length - dynamic_params.add_mod_p0_suboffset - 1;
        assert_range_u128_from_u256(x);
        
        // Offset of add_mod/p0 is too big.
         x = dynamic_params.add_mod_row_ratio - dynamic_params.add_mod_p0_suboffset * dynamic_params.memory_units_row_ratio - 1;
        assert_range_u128_from_u256(x);
        
        // Offset of add_mod/p1 must be nonnegative.
         x = dynamic_params.add_mod_p1_suboffset;
        assert_range_u128_from_u256(x);
        
        // Offset of add_mod/p1 is too big.
         x = trace_length - dynamic_params.add_mod_p1_suboffset - 1;
        assert_range_u128_from_u256(x);
        
        // Offset of add_mod/p1 is too big.
         x = dynamic_params.add_mod_row_ratio - dynamic_params.add_mod_p1_suboffset * dynamic_params.memory_units_row_ratio - 1;
        assert_range_u128_from_u256(x);
        
        // Offset of add_mod/p2 must be nonnegative.
         x = dynamic_params.add_mod_p2_suboffset;
        assert_range_u128_from_u256(x);
        
        // Offset of add_mod/p2 is too big.
         x = trace_length - dynamic_params.add_mod_p2_suboffset - 1;
        assert_range_u128_from_u256(x);
        
        // Offset of add_mod/p2 is too big.
         x = dynamic_params.add_mod_row_ratio - dynamic_params.add_mod_p2_suboffset * dynamic_params.memory_units_row_ratio - 1;
        assert_range_u128_from_u256(x);
        
        // Offset of add_mod/p3 must be nonnegative.
         x = dynamic_params.add_mod_p3_suboffset;
        assert_range_u128_from_u256(x);
        
        // Offset of add_mod/p3 is too big.
         x = trace_length - dynamic_params.add_mod_p3_suboffset - 1;
        assert_range_u128_from_u256(x);
        
        // Offset of add_mod/p3 is too big.
         x = dynamic_params.add_mod_row_ratio - dynamic_params.add_mod_p3_suboffset * dynamic_params.memory_units_row_ratio - 1;
        assert_range_u128_from_u256(x);
        
        // Offset of add_mod/values_ptr must be nonnegative.
         x = dynamic_params.add_mod_values_ptr_suboffset;
        assert_range_u128_from_u256(x);
        
        // Offset of add_mod/values_ptr is too big.
         x = trace_length - dynamic_params.add_mod_values_ptr_suboffset - 1;
        assert_range_u128_from_u256(x);
        
        // Offset of add_mod/values_ptr is too big.
         x = dynamic_params.add_mod_row_ratio - dynamic_params.add_mod_values_ptr_suboffset * dynamic_params.memory_units_row_ratio - 1;
        assert_range_u128_from_u256(x);
        
        // Offset of add_mod/offsets_ptr must be nonnegative.
         x = dynamic_params.add_mod_offsets_ptr_suboffset;
        assert_range_u128_from_u256(x);
        
        // Offset of add_mod/offsets_ptr is too big.
         x = trace_length - dynamic_params.add_mod_offsets_ptr_suboffset - 1;
        assert_range_u128_from_u256(x);
        
        // Offset of add_mod/offsets_ptr is too big.
         x = dynamic_params.add_mod_row_ratio - dynamic_params.add_mod_offsets_ptr_suboffset * dynamic_params.memory_units_row_ratio - 1;
        assert_range_u128_from_u256(x);
        
        // Offset of add_mod/n must be nonnegative.
         x = dynamic_params.add_mod_n_suboffset;
        assert_range_u128_from_u256(x);
        
        // Offset of add_mod/n is too big.
         x = trace_length - dynamic_params.add_mod_n_suboffset - 1;
        assert_range_u128_from_u256(x);
        
        // Offset of add_mod/n is too big.
         x = dynamic_params.add_mod_row_ratio - dynamic_params.add_mod_n_suboffset * dynamic_params.memory_units_row_ratio - 1;
        assert_range_u128_from_u256(x);
        
        // Offset of add_mod/a_offset must be nonnegative.
         x = dynamic_params.add_mod_a_offset_suboffset;
        assert_range_u128_from_u256(x);
        
        // Offset of add_mod/a_offset is too big.
         x = trace_length - dynamic_params.add_mod_a_offset_suboffset - 1;
        assert_range_u128_from_u256(x);
        
        // Offset of add_mod/a_offset is too big.
         x = dynamic_params.add_mod_row_ratio - dynamic_params.add_mod_a_offset_suboffset * dynamic_params.memory_units_row_ratio - 1;
        assert_range_u128_from_u256(x);
        
        // Offset of add_mod/b_offset must be nonnegative.
         x = dynamic_params.add_mod_b_offset_suboffset;
        assert_range_u128_from_u256(x);
        
        // Offset of add_mod/b_offset is too big.
         x = trace_length - dynamic_params.add_mod_b_offset_suboffset - 1;
        assert_range_u128_from_u256(x);
        
        // Offset of add_mod/b_offset is too big.
         x = dynamic_params.add_mod_row_ratio - dynamic_params.add_mod_b_offset_suboffset * dynamic_params.memory_units_row_ratio - 1;
        assert_range_u128_from_u256(x);
        
        // Offset of add_mod/c_offset must be nonnegative.
         x = dynamic_params.add_mod_c_offset_suboffset;
        assert_range_u128_from_u256(x);
        
        // Offset of add_mod/c_offset is too big.
         x = trace_length - dynamic_params.add_mod_c_offset_suboffset - 1;
        assert_range_u128_from_u256(x);
        
        // Offset of add_mod/c_offset is too big.
         x = dynamic_params.add_mod_row_ratio - dynamic_params.add_mod_c_offset_suboffset * dynamic_params.memory_units_row_ratio - 1;
        assert_range_u128_from_u256(x);
        
        // Offset of add_mod/a0 must be nonnegative.
         x = dynamic_params.add_mod_a0_suboffset;
        assert_range_u128_from_u256(x);
        
        // Offset of add_mod/a0 is too big.
         x = trace_length - dynamic_params.add_mod_a0_suboffset - 1;
        assert_range_u128_from_u256(x);
        
        // Offset of add_mod/a0 is too big.
         x = dynamic_params.add_mod_row_ratio - dynamic_params.add_mod_a0_suboffset * dynamic_params.memory_units_row_ratio - 1;
        assert_range_u128_from_u256(x);
        
        // Offset of add_mod/a1 must be nonnegative.
         x = dynamic_params.add_mod_a1_suboffset;
        assert_range_u128_from_u256(x);
        
        // Offset of add_mod/a1 is too big.
         x = trace_length - dynamic_params.add_mod_a1_suboffset - 1;
        assert_range_u128_from_u256(x);
        
        // Offset of add_mod/a1 is too big.
         x = dynamic_params.add_mod_row_ratio - dynamic_params.add_mod_a1_suboffset *  dynamic_params.memory_units_row_ratio - 1;
        assert_range_u128_from_u256(x);
        
        // Offset of add_mod/a2 must be nonnegative.
         x = dynamic_params.add_mod_a2_suboffset;
        assert_range_u128_from_u256(x);
        
        // Offset of add_mod/a2 is too big.
         x = trace_length - dynamic_params.add_mod_a2_suboffset - 1;
        assert_range_u128_from_u256(x);
        
        // Offset of add_mod/a2 is too big.
         x = dynamic_params.add_mod_row_ratio - dynamic_params.add_mod_a2_suboffset * dynamic_params.memory_units_row_ratio - 1;
        assert_range_u128_from_u256(x);
        
        // Offset of add_mod/a3 must be nonnegative.
         x = dynamic_params.add_mod_a3_suboffset;
        assert_range_u128_from_u256(x);
        
        // Offset of add_mod/a3 is too big.
         x = trace_length - dynamic_params.add_mod_a3_suboffset - 1;
        assert_range_u128_from_u256(x);
        
        // Offset of add_mod/a3 is too big.
         x = dynamic_params.add_mod_row_ratio - dynamic_params.add_mod_a3_suboffset * dynamic_params.memory_units_row_ratio - 1;
        assert_range_u128_from_u256(x);
        
        // Offset of add_mod/b0 must be nonnegative.
         x = dynamic_params.add_mod_b0_suboffset;
        assert_range_u128_from_u256(x);
        
        // Offset of add_mod/b0 is too big.
         x = trace_length - dynamic_params.add_mod_b0_suboffset - 1;
        assert_range_u128_from_u256(x);
        
        // Offset of add_mod/b0 is too big.
         x = dynamic_params.add_mod_row_ratio - dynamic_params.add_mod_b0_suboffset * dynamic_params.memory_units_row_ratio - 1;
        assert_range_u128_from_u256(x);
        
        // Offset of add_mod/b1 must be nonnegative.
         x = dynamic_params.add_mod_b1_suboffset;
        assert_range_u128_from_u256(x);
        
        // Offset of add_mod/b1 is too big.
         x = trace_length - dynamic_params.add_mod_b1_suboffset - 1;
        assert_range_u128_from_u256(x);
        
        // Offset of add_mod/b1 is too big.
         x = dynamic_params.add_mod_row_ratio - dynamic_params.add_mod_b1_suboffset *  dynamic_params.memory_units_row_ratio - 1;
        assert_range_u128_from_u256(x);
        
        // Offset of add_mod/b2 must be nonnegative.
         x = dynamic_params.add_mod_b2_suboffset;
        assert_range_u128_from_u256(x);
        
        // Offset of add_mod/b2 is too big.
         x = trace_length - dynamic_params.add_mod_b2_suboffset - 1;
        assert_range_u128_from_u256(x);
        
        // Offset of add_mod/b2 is too big.
         x = dynamic_params.add_mod_row_ratio - dynamic_params.add_mod_b2_suboffset * dynamic_params.memory_units_row_ratio - 1;
        assert_range_u128_from_u256(x);
        
        // Offset of add_mod/b3 must be nonnegative.
         x = dynamic_params.add_mod_b3_suboffset;
        assert_range_u128_from_u256(x);
        
        // Offset of add_mod/b3 is too big.
         x = trace_length - dynamic_params.add_mod_b3_suboffset - 1;
        assert_range_u128_from_u256(x);
        
        // Offset of add_mod/b3 is too big.
         x = dynamic_params.add_mod_row_ratio - dynamic_params.add_mod_b3_suboffset * dynamic_params.memory_units_row_ratio - 1;
        assert_range_u128_from_u256(x);
        
        // Offset of add_mod/c0 must be nonnegative.
         x = dynamic_params.add_mod_c0_suboffset;
        assert_range_u128_from_u256(x);
        
        // Offset of add_mod/c0 is too big.
         x = trace_length - dynamic_params.add_mod_c0_suboffset - 1;
        assert_range_u128_from_u256(x);
        
        // Offset of add_mod/c0 is too big.
         x = dynamic_params.add_mod_row_ratio - dynamic_params.add_mod_c0_suboffset *  dynamic_params.memory_units_row_ratio - 1;
        assert_range_u128_from_u256(x);
        
        // Offset of add_mod/c1 must be nonnegative.
         x = dynamic_params.add_mod_c1_suboffset;
        assert_range_u128_from_u256(x);
        
        // Offset of add_mod/c1 is too big.
         x = trace_length - dynamic_params.add_mod_c1_suboffset - 1;
        assert_range_u128_from_u256(x);
        
        // Offset of add_mod/c1 is too big.
         x = dynamic_params.add_mod_row_ratio - dynamic_params.add_mod_c1_suboffset *  dynamic_params.memory_units_row_ratio - 1;
        assert_range_u128_from_u256(x);
        
        // Offset of add_mod/c2 must be nonnegative.
         x = dynamic_params.add_mod_c2_suboffset;
        assert_range_u128_from_u256(x);
        
        // Offset of add_mod/c2 is too big.
         x = trace_length - dynamic_params.add_mod_c2_suboffset - 1;
        assert_range_u128_from_u256(x);
        
        // Offset of add_mod/c2 is too big.
         x = dynamic_params.add_mod_row_ratio - dynamic_params.add_mod_c2_suboffset * dynamic_params.memory_units_row_ratio - 1;
        assert_range_u128_from_u256(x);
        
        // Offset of add_mod/c3 must be nonnegative.
         x = dynamic_params.add_mod_c3_suboffset;
        assert_range_u128_from_u256(x);
        
        // Offset of add_mod/c3 is too big.
         x = trace_length - dynamic_params.add_mod_c3_suboffset - 1;
        assert_range_u128_from_u256(x);
        
        // Offset of add_mod/c3 is too big.
         x = dynamic_params.add_mod_row_ratio - dynamic_params.add_mod_c3_suboffset * dynamic_params.memory_units_row_ratio - 1;
        assert_range_u128_from_u256(x);
    }

    if (dynamic_params.uses_mul_mod_builtin != 0) {
         
        // Row ratio should be a power of 2, smaller than trace length.
         x = dynamic_params.mul_mod_row_ratio;
        assert_is_power_of_2(x.into());
        // Dimension should be a power of 2.
         x = (trace_length /  dynamic_params.mul_mod_row_ratio);
        assert_is_power_of_2(x.into());
        // Index out of range.
         x = (trace_length /  dynamic_params.mul_mod_row_ratio) - 1;
        assert_range_u128_from_u256(x);
        
        // Index should be non negative.
         x = (trace_length /  dynamic_params.mul_mod_row_ratio);
        assert_range_u128_from_u256(x);
        
        // Coset step (memberexpression(trace_length)) must be a power of two.
         x = trace_length;
        assert_is_power_of_2(x.into());
        // Offset of mul_mod/p0 must be nonnegative.
         x = dynamic_params.mul_mod_p0_suboffset;
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/p0 is too big.
         x = trace_length - dynamic_params.mul_mod_p0_suboffset - 1;
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/p0 is too big.
         x = dynamic_params.mul_mod_row_ratio - dynamic_params.mul_mod_p0_suboffset * dynamic_params.memory_units_row_ratio - 1;
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/p1 must be nonnegative.
         x = dynamic_params.mul_mod_p1_suboffset;
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/p1 is too big.
         x = trace_length - dynamic_params.mul_mod_p1_suboffset - 1;
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/p1 is too big.
         x = dynamic_params.mul_mod_row_ratio  - dynamic_params.mul_mod_p1_suboffset * dynamic_params.memory_units_row_ratio -  1
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/p2 must be nonnegative.
         x = dynamic_params.mul_mod_p2_suboffset;
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/p2 is too big.
         x = trace_length - dynamic_params.mul_mod_p2_suboffset - 1;
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/p2 is too big.
         x = dynamic_params.mul_mod_row_ratio  - dynamic_params.mul_mod_p2_suboffset * dynamic_params.memory_units_row_ratio -  1
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/p3 must be nonnegative.
         x = dynamic_params.mul_mod_p3_suboffset;
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/p3 is too big.
         x = trace_length - dynamic_params.mul_mod_p3_suboffset - 1;
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/p3 is too big.
         x = dynamic_params.mul_mod_row_ratio  - dynamic_params.mul_mod_p3_suboffset * dynamic_params.memory_units_row_ratio -  1
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/values_ptr must be nonnegative.
         x = dynamic_params.mul_mod_values_ptr_suboffset;
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/values_ptr is too big.
         x = trace_length - dynamic_params.mul_mod_values_ptr_suboffset - 1;
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/values_ptr is too big.
         x = dynamic_params.mul_mod_row_ratio  - 
                dynamic_params.mul_mod_values_ptr_suboffset * dynamic_params.memory_units_row_ratio
             -  1
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/offsets_ptr must be nonnegative.
         x = dynamic_params.mul_mod_offsets_ptr_suboffset;
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/offsets_ptr is too big.
         x = trace_length - dynamic_params.mul_mod_offsets_ptr_suboffset - 1;
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/offsets_ptr is too big.
         x = dynamic_params.mul_mod_row_ratio  - 
                dynamic_params.mul_mod_offsets_ptr_suboffset * dynamic_params.memory_units_row_ratio
             -  1
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/n must be nonnegative.
         x = dynamic_params.mul_mod_n_suboffset;
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/n is too big.
         x = trace_length - dynamic_params.mul_mod_n_suboffset - 1;
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/n is too big.
         x = dynamic_params.mul_mod_row_ratio  - dynamic_params.mul_mod_n_suboffset * dynamic_params.memory_units_row_ratio -  1
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/a_offset must be nonnegative.
         x = dynamic_params.mul_mod_a_offset_suboffset;
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/a_offset is too big.
         x = trace_length - dynamic_params.mul_mod_a_offset_suboffset - 1;
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/a_offset is too big.
         x = dynamic_params.mul_mod_row_ratio  - 
                dynamic_params.mul_mod_a_offset_suboffset * dynamic_params.memory_units_row_ratio
             -  1
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/b_offset must be nonnegative.
         x = dynamic_params.mul_mod_b_offset_suboffset;
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/b_offset is too big.
         x = trace_length - dynamic_params.mul_mod_b_offset_suboffset - 1;
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/b_offset is too big.
         x = dynamic_params.mul_mod_row_ratio  - 
                dynamic_params.mul_mod_b_offset_suboffset * dynamic_params.memory_units_row_ratio
             -  1
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/c_offset must be nonnegative.
         x = dynamic_params.mul_mod_c_offset_suboffset;
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/c_offset is too big.
         x = trace_length - dynamic_params.mul_mod_c_offset_suboffset - 1;
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/c_offset is too big.
         x = dynamic_params.mul_mod_row_ratio  - 
                dynamic_params.mul_mod_c_offset_suboffset * dynamic_params.memory_units_row_ratio
             -  1
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/a0 must be nonnegative.
         x = dynamic_params.mul_mod_a0_suboffset;
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/a0 is too big.
         x = trace_length - dynamic_params.mul_mod_a0_suboffset - 1;
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/a0 is too big.
         x = dynamic_params.mul_mod_row_ratio  - dynamic_params.mul_mod_a0_suboffset * dynamic_params.memory_units_row_ratio -  1
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/a1 must be nonnegative.
         x = dynamic_params.mul_mod_a1_suboffset;
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/a1 is too big.
         x = trace_length - dynamic_params.mul_mod_a1_suboffset - 1;
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/a1 is too big.
         x = dynamic_params.mul_mod_row_ratio  - dynamic_params.mul_mod_a1_suboffset * dynamic_params.memory_units_row_ratio -  1
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/a2 must be nonnegative.
         x = dynamic_params.mul_mod_a2_suboffset;
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/a2 is too big.
         x = trace_length - dynamic_params.mul_mod_a2_suboffset - 1;
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/a2 is too big.
         x = dynamic_params.mul_mod_row_ratio  - dynamic_params.mul_mod_a2_suboffset * dynamic_params.memory_units_row_ratio -  1
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/a3 must be nonnegative.
         x = dynamic_params.mul_mod_a3_suboffset;
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/a3 is too big.
         x = trace_length - dynamic_params.mul_mod_a3_suboffset - 1;
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/a3 is too big.
         x = dynamic_params.mul_mod_row_ratio  - dynamic_params.mul_mod_a3_suboffset * dynamic_params.memory_units_row_ratio -  1
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/b0 must be nonnegative.
         x = dynamic_params.mul_mod_b0_suboffset;
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/b0 is too big.
         x = trace_length - dynamic_params.mul_mod_b0_suboffset - 1;
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/b0 is too big.
         x = dynamic_params.mul_mod_row_ratio  - dynamic_params.mul_mod_b0_suboffset * dynamic_params.memory_units_row_ratio -  1
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/b1 must be nonnegative.
         x = dynamic_params.mul_mod_b1_suboffset;
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/b1 is too big.
         x = trace_length - dynamic_params.mul_mod_b1_suboffset - 1;
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/b1 is too big.
         x = dynamic_params.mul_mod_row_ratio  - dynamic_params.mul_mod_b1_suboffset * dynamic_params.memory_units_row_ratio -  1
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/b2 must be nonnegative.
         x = dynamic_params.mul_mod_b2_suboffset;
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/b2 is too big.
         x = trace_length - dynamic_params.mul_mod_b2_suboffset - 1;
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/b2 is too big.
         x = dynamic_params.mul_mod_row_ratio  - dynamic_params.mul_mod_b2_suboffset * dynamic_params.memory_units_row_ratio -  1
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/b3 must be nonnegative.
         x = dynamic_params.mul_mod_b3_suboffset;
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/b3 is too big.
         x = trace_length - dynamic_params.mul_mod_b3_suboffset - 1;
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/b3 is too big.
         x = dynamic_params.mul_mod_row_ratio  - dynamic_params.mul_mod_b3_suboffset * dynamic_params.memory_units_row_ratio -  1
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/c0 must be nonnegative.
         x = dynamic_params.mul_mod_c0_suboffset;
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/c0 is too big.
         x = trace_length - dynamic_params.mul_mod_c0_suboffset - 1;
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/c0 is too big.
         x = dynamic_params.mul_mod_row_ratio  - dynamic_params.mul_mod_c0_suboffset * dynamic_params.memory_units_row_ratio -  1
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/c1 must be nonnegative.
         x = dynamic_params.mul_mod_c1_suboffset;
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/c1 is too big.
         x = trace_length - dynamic_params.mul_mod_c1_suboffset - 1;
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/c1 is too big.
         x = dynamic_params.mul_mod_row_ratio  - dynamic_params.mul_mod_c1_suboffset * dynamic_params.memory_units_row_ratio -  1
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/c2 must be nonnegative.
         x = dynamic_params.mul_mod_c2_suboffset;
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/c2 is too big.
         x = trace_length - dynamic_params.mul_mod_c2_suboffset - 1;
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/c2 is too big.
         x = dynamic_params.mul_mod_row_ratio  - dynamic_params.mul_mod_c2_suboffset * dynamic_params.memory_units_row_ratio -  1
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/c3 must be nonnegative.
         x = dynamic_params.mul_mod_c3_suboffset;
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/c3 is too big.
         x = trace_length - dynamic_params.mul_mod_c3_suboffset - 1;
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/c3 is too big.
         x = dynamic_params.mul_mod_row_ratio  - dynamic_params.mul_mod_c3_suboffset * dynamic_params.memory_units_row_ratio -  1
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/p_multiplier0/part0 must be nonnegative.
         x = dynamic_params.mul_mod_p_multiplier0_part0_suboffset;
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/p_multiplier0/part0 is too big.
         x = trace_length - dynamic_params.mul_mod_p_multiplier0_part0_suboffset - 1;
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/p_multiplier0/part0 is too big.
         x = dynamic_params.mul_mod_row_ratio  - 
                dynamic_params.mul_mod_p_multiplier0_part0_suboffset * 
                dynamic_params.range_check_units_row_ratio
             -  1
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/p_multiplier0/part1 must be nonnegative.
         x = dynamic_params.mul_mod_p_multiplier0_part1_suboffset;
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/p_multiplier0/part1 is too big.
         x = trace_length - dynamic_params.mul_mod_p_multiplier0_part1_suboffset - 1;
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/p_multiplier0/part1 is too big.
         x = dynamic_params.mul_mod_row_ratio  - 
                dynamic_params.mul_mod_p_multiplier0_part1_suboffset * 
                dynamic_params.range_check_units_row_ratio
             -  1
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/p_multiplier0/part2 must be nonnegative.
         x = dynamic_params.mul_mod_p_multiplier0_part2_suboffset;
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/p_multiplier0/part2 is too big.
         x = trace_length - dynamic_params.mul_mod_p_multiplier0_part2_suboffset - 1;
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/p_multiplier0/part2 is too big.
         x = dynamic_params.mul_mod_row_ratio  - 
                dynamic_params.mul_mod_p_multiplier0_part2_suboffset * 
                dynamic_params.range_check_units_row_ratio
             -  1
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/p_multiplier0/part3 must be nonnegative.
         x = dynamic_params.mul_mod_p_multiplier0_part3_suboffset;
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/p_multiplier0/part3 is too big.
         x = trace_length - dynamic_params.mul_mod_p_multiplier0_part3_suboffset - 1;
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/p_multiplier0/part3 is too big.
         x = dynamic_params.mul_mod_row_ratio  - 
                dynamic_params.mul_mod_p_multiplier0_part3_suboffset * 
                dynamic_params.range_check_units_row_ratio
             -  1
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/p_multiplier0/part4 must be nonnegative.
         x = dynamic_params.mul_mod_p_multiplier0_part4_suboffset;
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/p_multiplier0/part4 is too big.
         x = trace_length - dynamic_params.mul_mod_p_multiplier0_part4_suboffset - 1;
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/p_multiplier0/part4 is too big.
         x = dynamic_params.mul_mod_row_ratio  - 
                dynamic_params.mul_mod_p_multiplier0_part4_suboffset * 
                dynamic_params.range_check_units_row_ratio
             -  1
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/p_multiplier0/part5 must be nonnegative.
         x = dynamic_params.mul_mod_p_multiplier0_part5_suboffset;
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/p_multiplier0/part5 is too big.
         x = trace_length - dynamic_params.mul_mod_p_multiplier0_part5_suboffset - 1;
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/p_multiplier0/part5 is too big.
         x = dynamic_params.mul_mod_row_ratio  - 
                dynamic_params.mul_mod_p_multiplier0_part5_suboffset * 
                dynamic_params.range_check_units_row_ratio
             -  1
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/p_multiplier1/part0 must be nonnegative.
         x = dynamic_params.mul_mod_p_multiplier1_part0_suboffset;
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/p_multiplier1/part0 is too big.
         x = trace_length - dynamic_params.mul_mod_p_multiplier1_part0_suboffset - 1;
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/p_multiplier1/part0 is too big.
         x = dynamic_params.mul_mod_row_ratio  - 
                dynamic_params.mul_mod_p_multiplier1_part0_suboffset * 
                dynamic_params.range_check_units_row_ratio
             -  1
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/p_multiplier1/part1 must be nonnegative.
         x = dynamic_params.mul_mod_p_multiplier1_part1_suboffset;
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/p_multiplier1/part1 is too big.
         x = trace_length - dynamic_params.mul_mod_p_multiplier1_part1_suboffset - 1;
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/p_multiplier1/part1 is too big.
         x = dynamic_params.mul_mod_row_ratio  - 
                dynamic_params.mul_mod_p_multiplier1_part1_suboffset * 
                dynamic_params.range_check_units_row_ratio
             -  1
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/p_multiplier1/part2 must be nonnegative.
         x = dynamic_params.mul_mod_p_multiplier1_part2_suboffset;
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/p_multiplier1/part2 is too big.
         x = trace_length - dynamic_params.mul_mod_p_multiplier1_part2_suboffset - 1;
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/p_multiplier1/part2 is too big.
         x = dynamic_params.mul_mod_row_ratio  - 
                dynamic_params.mul_mod_p_multiplier1_part2_suboffset * 
                dynamic_params.range_check_units_row_ratio
             -  1
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/p_multiplier1/part3 must be nonnegative.
         x = dynamic_params.mul_mod_p_multiplier1_part3_suboffset;
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/p_multiplier1/part3 is too big.
         x = trace_length - dynamic_params.mul_mod_p_multiplier1_part3_suboffset - 1;
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/p_multiplier1/part3 is too big.
         x = dynamic_params.mul_mod_row_ratio  - 
                dynamic_params.mul_mod_p_multiplier1_part3_suboffset * 
                dynamic_params.range_check_units_row_ratio
             -  1
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/p_multiplier1/part4 must be nonnegative.
         x = dynamic_params.mul_mod_p_multiplier1_part4_suboffset;
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/p_multiplier1/part4 is too big.
         x = trace_length - dynamic_params.mul_mod_p_multiplier1_part4_suboffset - 1;
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/p_multiplier1/part4 is too big.
         x = dynamic_params.mul_mod_row_ratio  - 
                dynamic_params.mul_mod_p_multiplier1_part4_suboffset * 
                dynamic_params.range_check_units_row_ratio
             -  1
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/p_multiplier1/part5 must be nonnegative.
         x = dynamic_params.mul_mod_p_multiplier1_part5_suboffset;
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/p_multiplier1/part5 is too big.
         x = trace_length - dynamic_params.mul_mod_p_multiplier1_part5_suboffset - 1;
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/p_multiplier1/part5 is too big.
         x = dynamic_params.mul_mod_row_ratio  - 
                dynamic_params.mul_mod_p_multiplier1_part5_suboffset * 
                dynamic_params.range_check_units_row_ratio
             -  1
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/p_multiplier2/part0 must be nonnegative.
         x = dynamic_params.mul_mod_p_multiplier2_part0_suboffset;
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/p_multiplier2/part0 is too big.
         x = trace_length - dynamic_params.mul_mod_p_multiplier2_part0_suboffset - 1;
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/p_multiplier2/part0 is too big.
         x = dynamic_params.mul_mod_row_ratio  - 
                dynamic_params.mul_mod_p_multiplier2_part0_suboffset * 
                dynamic_params.range_check_units_row_ratio
             -  1
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/p_multiplier2/part1 must be nonnegative.
         x = dynamic_params.mul_mod_p_multiplier2_part1_suboffset;
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/p_multiplier2/part1 is too big.
         x = trace_length - dynamic_params.mul_mod_p_multiplier2_part1_suboffset - 1;
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/p_multiplier2/part1 is too big.
         x = dynamic_params.mul_mod_row_ratio  - 
                dynamic_params.mul_mod_p_multiplier2_part1_suboffset * 
                dynamic_params.range_check_units_row_ratio
             -  1
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/p_multiplier2/part2 must be nonnegative.
         x = dynamic_params.mul_mod_p_multiplier2_part2_suboffset;
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/p_multiplier2/part2 is too big.
         x = trace_length - dynamic_params.mul_mod_p_multiplier2_part2_suboffset - 1;
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/p_multiplier2/part2 is too big.
         x = dynamic_params.mul_mod_row_ratio  - 
                dynamic_params.mul_mod_p_multiplier2_part2_suboffset * 
                dynamic_params.range_check_units_row_ratio
             -  1
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/p_multiplier2/part3 must be nonnegative.
         x = dynamic_params.mul_mod_p_multiplier2_part3_suboffset;
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/p_multiplier2/part3 is too big.
         x = trace_length - dynamic_params.mul_mod_p_multiplier2_part3_suboffset - 1;
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/p_multiplier2/part3 is too big.
         x = dynamic_params.mul_mod_row_ratio  - 
                dynamic_params.mul_mod_p_multiplier2_part3_suboffset * 
                dynamic_params.range_check_units_row_ratio
             -  1
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/p_multiplier2/part4 must be nonnegative.
         x = dynamic_params.mul_mod_p_multiplier2_part4_suboffset;
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/p_multiplier2/part4 is too big.
         x = trace_length - dynamic_params.mul_mod_p_multiplier2_part4_suboffset - 1;
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/p_multiplier2/part4 is too big.
         x = dynamic_params.mul_mod_row_ratio  - 
                dynamic_params.mul_mod_p_multiplier2_part4_suboffset * 
                dynamic_params.range_check_units_row_ratio
             -  1
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/p_multiplier2/part5 must be nonnegative.
         x = dynamic_params.mul_mod_p_multiplier2_part5_suboffset;
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/p_multiplier2/part5 is too big.
         x = trace_length - dynamic_params.mul_mod_p_multiplier2_part5_suboffset - 1;
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/p_multiplier2/part5 is too big.
         x = dynamic_params.mul_mod_row_ratio  - 
                dynamic_params.mul_mod_p_multiplier2_part5_suboffset * 
                dynamic_params.range_check_units_row_ratio
             -  1
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/p_multiplier3/part0 must be nonnegative.
         x = dynamic_params.mul_mod_p_multiplier3_part0_suboffset;
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/p_multiplier3/part0 is too big.
         x = trace_length - dynamic_params.mul_mod_p_multiplier3_part0_suboffset - 1;
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/p_multiplier3/part0 is too big.
         x = dynamic_params.mul_mod_row_ratio  - 
                dynamic_params.mul_mod_p_multiplier3_part0_suboffset * 
                dynamic_params.range_check_units_row_ratio
             -  1
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/p_multiplier3/part1 must be nonnegative.
         x = dynamic_params.mul_mod_p_multiplier3_part1_suboffset;
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/p_multiplier3/part1 is too big.
         x = trace_length - dynamic_params.mul_mod_p_multiplier3_part1_suboffset - 1;
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/p_multiplier3/part1 is too big.
         x = dynamic_params.mul_mod_row_ratio  - 
                dynamic_params.mul_mod_p_multiplier3_part1_suboffset * 
                dynamic_params.range_check_units_row_ratio
             -  1
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/p_multiplier3/part2 must be nonnegative.
         x = dynamic_params.mul_mod_p_multiplier3_part2_suboffset;
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/p_multiplier3/part2 is too big.
         x = trace_length - dynamic_params.mul_mod_p_multiplier3_part2_suboffset - 1;
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/p_multiplier3/part2 is too big.
         x = dynamic_params.mul_mod_row_ratio  - 
                dynamic_params.mul_mod_p_multiplier3_part2_suboffset * 
                dynamic_params.range_check_units_row_ratio
             -  1
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/p_multiplier3/part3 must be nonnegative.
         x = dynamic_params.mul_mod_p_multiplier3_part3_suboffset;
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/p_multiplier3/part3 is too big.
         x = trace_length - dynamic_params.mul_mod_p_multiplier3_part3_suboffset - 1;
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/p_multiplier3/part3 is too big.
         x = dynamic_params.mul_mod_row_ratio  - 
                dynamic_params.mul_mod_p_multiplier3_part3_suboffset * 
                dynamic_params.range_check_units_row_ratio
             -  1
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/p_multiplier3/part4 must be nonnegative.
         x = dynamic_params.mul_mod_p_multiplier3_part4_suboffset;
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/p_multiplier3/part4 is too big.
         x = trace_length - dynamic_params.mul_mod_p_multiplier3_part4_suboffset - 1;
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/p_multiplier3/part4 is too big.
         x = dynamic_params.mul_mod_row_ratio  - 
                dynamic_params.mul_mod_p_multiplier3_part4_suboffset * 
                dynamic_params.range_check_units_row_ratio
             -  1
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/p_multiplier3/part5 must be nonnegative.
         x = dynamic_params.mul_mod_p_multiplier3_part5_suboffset;
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/p_multiplier3/part5 is too big.
         x = trace_length - dynamic_params.mul_mod_p_multiplier3_part5_suboffset - 1;
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/p_multiplier3/part5 is too big.
         x = dynamic_params.mul_mod_row_ratio  - 
                dynamic_params.mul_mod_p_multiplier3_part5_suboffset * 
                dynamic_params.range_check_units_row_ratio
             -  1
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/carry0/part0 must be nonnegative.
         x = dynamic_params.mul_mod_carry0_part0_suboffset;
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/carry0/part0 is too big.
         x = trace_length - dynamic_params.mul_mod_carry0_part0_suboffset - 1;
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/carry0/part0 is too big.
         x = dynamic_params.mul_mod_row_ratio  - 
                dynamic_params.mul_mod_carry0_part0_suboffset * 
                dynamic_params.range_check_units_row_ratio
             -  1
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/carry0/part1 must be nonnegative.
         x = dynamic_params.mul_mod_carry0_part1_suboffset;
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/carry0/part1 is too big.
         x = trace_length - dynamic_params.mul_mod_carry0_part1_suboffset - 1;
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/carry0/part1 is too big.
         x = dynamic_params.mul_mod_row_ratio  - 
                dynamic_params.mul_mod_carry0_part1_suboffset * 
                dynamic_params.range_check_units_row_ratio
             -  1
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/carry0/part2 must be nonnegative.
         x = dynamic_params.mul_mod_carry0_part2_suboffset;
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/carry0/part2 is too big.
         x = trace_length - dynamic_params.mul_mod_carry0_part2_suboffset - 1;
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/carry0/part2 is too big.
         x = dynamic_params.mul_mod_row_ratio  - 
                dynamic_params.mul_mod_carry0_part2_suboffset * 
                dynamic_params.range_check_units_row_ratio
             -  1
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/carry0/part3 must be nonnegative.
         x = dynamic_params.mul_mod_carry0_part3_suboffset;
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/carry0/part3 is too big.
         x = trace_length - dynamic_params.mul_mod_carry0_part3_suboffset - 1;
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/carry0/part3 is too big.
         x = dynamic_params.mul_mod_row_ratio  - 
                dynamic_params.mul_mod_carry0_part3_suboffset * 
                dynamic_params.range_check_units_row_ratio
             -  1
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/carry0/part4 must be nonnegative.
         x = dynamic_params.mul_mod_carry0_part4_suboffset;
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/carry0/part4 is too big.
         x = trace_length - dynamic_params.mul_mod_carry0_part4_suboffset - 1;
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/carry0/part4 is too big.
         x = dynamic_params.mul_mod_row_ratio  - 
                dynamic_params.mul_mod_carry0_part4_suboffset * 
                dynamic_params.range_check_units_row_ratio
             -  1
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/carry0/part5 must be nonnegative.
         x = dynamic_params.mul_mod_carry0_part5_suboffset;
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/carry0/part5 is too big.
         x = trace_length - dynamic_params.mul_mod_carry0_part5_suboffset - 1;
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/carry0/part5 is too big.
         x = dynamic_params.mul_mod_row_ratio  - 
                dynamic_params.mul_mod_carry0_part5_suboffset * 
                dynamic_params.range_check_units_row_ratio
             -  1
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/carry0/part6 must be nonnegative.
         x = dynamic_params.mul_mod_carry0_part6_suboffset;
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/carry0/part6 is too big.
         x = trace_length - dynamic_params.mul_mod_carry0_part6_suboffset - 1;
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/carry0/part6 is too big.
         x = dynamic_params.mul_mod_row_ratio  - 
                dynamic_params.mul_mod_carry0_part6_suboffset * 
                dynamic_params.range_check_units_row_ratio
             -  1
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/carry1/part0 must be nonnegative.
         x = dynamic_params.mul_mod_carry1_part0_suboffset;
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/carry1/part0 is too big.
         x = trace_length - dynamic_params.mul_mod_carry1_part0_suboffset - 1;
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/carry1/part0 is too big.
         x = dynamic_params.mul_mod_row_ratio  - 
                dynamic_params.mul_mod_carry1_part0_suboffset * 
                dynamic_params.range_check_units_row_ratio
             -  1
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/carry1/part1 must be nonnegative.
         x = dynamic_params.mul_mod_carry1_part1_suboffset;
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/carry1/part1 is too big.
         x = trace_length - dynamic_params.mul_mod_carry1_part1_suboffset - 1;
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/carry1/part1 is too big.
         x = dynamic_params.mul_mod_row_ratio  - 
                dynamic_params.mul_mod_carry1_part1_suboffset * 
                dynamic_params.range_check_units_row_ratio
             -  1
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/carry1/part2 must be nonnegative.
         x = dynamic_params.mul_mod_carry1_part2_suboffset;
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/carry1/part2 is too big.
         x = trace_length - dynamic_params.mul_mod_carry1_part2_suboffset - 1;
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/carry1/part2 is too big.
         x = dynamic_params.mul_mod_row_ratio  - 
                dynamic_params.mul_mod_carry1_part2_suboffset * 
                dynamic_params.range_check_units_row_ratio
             -  1
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/carry1/part3 must be nonnegative.
         x = dynamic_params.mul_mod_carry1_part3_suboffset;
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/carry1/part3 is too big.
         x = trace_length - dynamic_params.mul_mod_carry1_part3_suboffset - 1;
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/carry1/part3 is too big.
         x = dynamic_params.mul_mod_row_ratio  - 
                dynamic_params.mul_mod_carry1_part3_suboffset * 
                dynamic_params.range_check_units_row_ratio
             -  1
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/carry1/part4 must be nonnegative.
         x = dynamic_params.mul_mod_carry1_part4_suboffset;
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/carry1/part4 is too big.
         x = trace_length - dynamic_params.mul_mod_carry1_part4_suboffset - 1;
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/carry1/part4 is too big.
         x = dynamic_params.mul_mod_row_ratio  - 
                dynamic_params.mul_mod_carry1_part4_suboffset * 
                dynamic_params.range_check_units_row_ratio
             -  1
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/carry1/part5 must be nonnegative.
         x = dynamic_params.mul_mod_carry1_part5_suboffset;
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/carry1/part5 is too big.
         x = trace_length - dynamic_params.mul_mod_carry1_part5_suboffset - 1;
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/carry1/part5 is too big.
         x = dynamic_params.mul_mod_row_ratio  - 
                dynamic_params.mul_mod_carry1_part5_suboffset * 
                dynamic_params.range_check_units_row_ratio
             -  1
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/carry1/part6 must be nonnegative.
         x = dynamic_params.mul_mod_carry1_part6_suboffset;
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/carry1/part6 is too big.
         x = trace_length - dynamic_params.mul_mod_carry1_part6_suboffset - 1;
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/carry1/part6 is too big.
         x = dynamic_params.mul_mod_row_ratio  - 
                dynamic_params.mul_mod_carry1_part6_suboffset * 
                dynamic_params.range_check_units_row_ratio
             -  1
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/carry2/part0 must be nonnegative.
         x = dynamic_params.mul_mod_carry2_part0_suboffset;
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/carry2/part0 is too big.
         x = trace_length - dynamic_params.mul_mod_carry2_part0_suboffset - 1;
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/carry2/part0 is too big.
         x = dynamic_params.mul_mod_row_ratio  - 
                dynamic_params.mul_mod_carry2_part0_suboffset * 
                dynamic_params.range_check_units_row_ratio
             -  1
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/carry2/part1 must be nonnegative.
         x = dynamic_params.mul_mod_carry2_part1_suboffset;
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/carry2/part1 is too big.
         x = trace_length - dynamic_params.mul_mod_carry2_part1_suboffset - 1;
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/carry2/part1 is too big.
         x = dynamic_params.mul_mod_row_ratio  - 
                dynamic_params.mul_mod_carry2_part1_suboffset * 
                dynamic_params.range_check_units_row_ratio
             -  1
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/carry2/part2 must be nonnegative.
         x = dynamic_params.mul_mod_carry2_part2_suboffset;
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/carry2/part2 is too big.
         x = trace_length - dynamic_params.mul_mod_carry2_part2_suboffset - 1;
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/carry2/part2 is too big.
         x = dynamic_params.mul_mod_row_ratio  - 
                dynamic_params.mul_mod_carry2_part2_suboffset * 
                dynamic_params.range_check_units_row_ratio
             -  1
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/carry2/part3 must be nonnegative.
         x = dynamic_params.mul_mod_carry2_part3_suboffset;
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/carry2/part3 is too big.
         x = trace_length - dynamic_params.mul_mod_carry2_part3_suboffset - 1;
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/carry2/part3 is too big.
         x = dynamic_params.mul_mod_row_ratio  - 
                dynamic_params.mul_mod_carry2_part3_suboffset * 
                dynamic_params.range_check_units_row_ratio
             -  1
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/carry2/part4 must be nonnegative.
         x = dynamic_params.mul_mod_carry2_part4_suboffset;
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/carry2/part4 is too big.
         x = trace_length - dynamic_params.mul_mod_carry2_part4_suboffset - 1;
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/carry2/part4 is too big.
         x = dynamic_params.mul_mod_row_ratio  - 
                dynamic_params.mul_mod_carry2_part4_suboffset * 
                dynamic_params.range_check_units_row_ratio
             -  1
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/carry2/part5 must be nonnegative.
         x = dynamic_params.mul_mod_carry2_part5_suboffset;
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/carry2/part5 is too big.
         x = trace_length - dynamic_params.mul_mod_carry2_part5_suboffset - 1;
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/carry2/part5 is too big.
         x = dynamic_params.mul_mod_row_ratio  - 
                dynamic_params.mul_mod_carry2_part5_suboffset * 
                dynamic_params.range_check_units_row_ratio
             -  1
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/carry2/part6 must be nonnegative.
         x = dynamic_params.mul_mod_carry2_part6_suboffset;
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/carry2/part6 is too big.
         x = trace_length - dynamic_params.mul_mod_carry2_part6_suboffset - 1;
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/carry2/part6 is too big.
         x = dynamic_params.mul_mod_row_ratio  - 
                dynamic_params.mul_mod_carry2_part6_suboffset * 
                dynamic_params.range_check_units_row_ratio
             -  1
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/carry3/part0 must be nonnegative.
         x = dynamic_params.mul_mod_carry3_part0_suboffset;
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/carry3/part0 is too big.
         x = trace_length - dynamic_params.mul_mod_carry3_part0_suboffset - 1;
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/carry3/part0 is too big.
         x = dynamic_params.mul_mod_row_ratio  - 
                dynamic_params.mul_mod_carry3_part0_suboffset * 
                dynamic_params.range_check_units_row_ratio
             -  1
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/carry3/part1 must be nonnegative.
         x = dynamic_params.mul_mod_carry3_part1_suboffset;
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/carry3/part1 is too big.
         x = trace_length - dynamic_params.mul_mod_carry3_part1_suboffset - 1;
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/carry3/part1 is too big.
         x = dynamic_params.mul_mod_row_ratio  - 
                dynamic_params.mul_mod_carry3_part1_suboffset * 
                dynamic_params.range_check_units_row_ratio
             -  1
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/carry3/part2 must be nonnegative.
         x = dynamic_params.mul_mod_carry3_part2_suboffset;
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/carry3/part2 is too big.
         x = trace_length - dynamic_params.mul_mod_carry3_part2_suboffset - 1;
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/carry3/part2 is too big.
         x = dynamic_params.mul_mod_row_ratio  - 
                dynamic_params.mul_mod_carry3_part2_suboffset * 
                dynamic_params.range_check_units_row_ratio
             -  1
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/carry3/part3 must be nonnegative.
         x = dynamic_params.mul_mod_carry3_part3_suboffset;
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/carry3/part3 is too big.
         x = trace_length - dynamic_params.mul_mod_carry3_part3_suboffset - 1;
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/carry3/part3 is too big.
         x = dynamic_params.mul_mod_row_ratio  - 
                dynamic_params.mul_mod_carry3_part3_suboffset * 
                dynamic_params.range_check_units_row_ratio
             -  1
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/carry3/part4 must be nonnegative.
         x = dynamic_params.mul_mod_carry3_part4_suboffset;
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/carry3/part4 is too big.
         x = trace_length - dynamic_params.mul_mod_carry3_part4_suboffset - 1;
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/carry3/part4 is too big.
         x = dynamic_params.mul_mod_row_ratio  - 
                dynamic_params.mul_mod_carry3_part4_suboffset * 
                dynamic_params.range_check_units_row_ratio
             -  1
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/carry3/part5 must be nonnegative.
         x = dynamic_params.mul_mod_carry3_part5_suboffset;
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/carry3/part5 is too big.
         x = trace_length - dynamic_params.mul_mod_carry3_part5_suboffset - 1;
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/carry3/part5 is too big.
         x = dynamic_params.mul_mod_row_ratio  - 
                dynamic_params.mul_mod_carry3_part5_suboffset * 
                dynamic_params.range_check_units_row_ratio
             -  1
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/carry3/part6 must be nonnegative.
         x = dynamic_params.mul_mod_carry3_part6_suboffset;
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/carry3/part6 is too big.
         x = trace_length - dynamic_params.mul_mod_carry3_part6_suboffset - 1;
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/carry3/part6 is too big.
         x = dynamic_params.mul_mod_row_ratio  - 
                dynamic_params.mul_mod_carry3_part6_suboffset * 
                dynamic_params.range_check_units_row_ratio
             -  1
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/carry4/part0 must be nonnegative.
         x = dynamic_params.mul_mod_carry4_part0_suboffset;
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/carry4/part0 is too big.
         x = trace_length - dynamic_params.mul_mod_carry4_part0_suboffset - 1;
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/carry4/part0 is too big.
         x = dynamic_params.mul_mod_row_ratio  - 
                dynamic_params.mul_mod_carry4_part0_suboffset * 
                dynamic_params.range_check_units_row_ratio
             -  1
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/carry4/part1 must be nonnegative.
         x = dynamic_params.mul_mod_carry4_part1_suboffset;
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/carry4/part1 is too big.
         x = trace_length - dynamic_params.mul_mod_carry4_part1_suboffset - 1;
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/carry4/part1 is too big.
         x = dynamic_params.mul_mod_row_ratio  - 
                dynamic_params.mul_mod_carry4_part1_suboffset * 
                dynamic_params.range_check_units_row_ratio
             -  1
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/carry4/part2 must be nonnegative.
         x = dynamic_params.mul_mod_carry4_part2_suboffset;
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/carry4/part2 is too big.
         x = trace_length - dynamic_params.mul_mod_carry4_part2_suboffset - 1;
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/carry4/part2 is too big.
         x = dynamic_params.mul_mod_row_ratio  - 
                dynamic_params.mul_mod_carry4_part2_suboffset * 
                dynamic_params.range_check_units_row_ratio
             -  1
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/carry4/part3 must be nonnegative.
         x = dynamic_params.mul_mod_carry4_part3_suboffset;
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/carry4/part3 is too big.
         x = trace_length - dynamic_params.mul_mod_carry4_part3_suboffset - 1;
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/carry4/part3 is too big.
         x = dynamic_params.mul_mod_row_ratio  - 
                dynamic_params.mul_mod_carry4_part3_suboffset * 
                dynamic_params.range_check_units_row_ratio
             -  1
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/carry4/part4 must be nonnegative.
         x = dynamic_params.mul_mod_carry4_part4_suboffset;
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/carry4/part4 is too big.
         x = trace_length - dynamic_params.mul_mod_carry4_part4_suboffset - 1;
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/carry4/part4 is too big.
         x = dynamic_params.mul_mod_row_ratio  - 
                dynamic_params.mul_mod_carry4_part4_suboffset * 
                dynamic_params.range_check_units_row_ratio
             -  1
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/carry4/part5 must be nonnegative.
         x = dynamic_params.mul_mod_carry4_part5_suboffset;
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/carry4/part5 is too big.
         x = trace_length - dynamic_params.mul_mod_carry4_part5_suboffset - 1;
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/carry4/part5 is too big.
         x = dynamic_params.mul_mod_row_ratio  - 
                dynamic_params.mul_mod_carry4_part5_suboffset * 
                dynamic_params.range_check_units_row_ratio
             -  1
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/carry4/part6 must be nonnegative.
         x = dynamic_params.mul_mod_carry4_part6_suboffset;
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/carry4/part6 is too big.
         x = trace_length - dynamic_params.mul_mod_carry4_part6_suboffset - 1;
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/carry4/part6 is too big.
         x = dynamic_params.mul_mod_row_ratio  - 
                dynamic_params.mul_mod_carry4_part6_suboffset * 
                dynamic_params.range_check_units_row_ratio
             -  1
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/carry5/part0 must be nonnegative.
         x = dynamic_params.mul_mod_carry5_part0_suboffset;
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/carry5/part0 is too big.
         x = trace_length - dynamic_params.mul_mod_carry5_part0_suboffset - 1;
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/carry5/part0 is too big.
         x = dynamic_params.mul_mod_row_ratio  - 
                dynamic_params.mul_mod_carry5_part0_suboffset * 
                dynamic_params.range_check_units_row_ratio
             -  1
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/carry5/part1 must be nonnegative.
         x = dynamic_params.mul_mod_carry5_part1_suboffset;
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/carry5/part1 is too big.
         x = trace_length - dynamic_params.mul_mod_carry5_part1_suboffset - 1;
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/carry5/part1 is too big.
         x = dynamic_params.mul_mod_row_ratio  - 
                dynamic_params.mul_mod_carry5_part1_suboffset * 
                dynamic_params.range_check_units_row_ratio
             -  1
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/carry5/part2 must be nonnegative.
         x = dynamic_params.mul_mod_carry5_part2_suboffset;
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/carry5/part2 is too big.
         x = trace_length - dynamic_params.mul_mod_carry5_part2_suboffset - 1;
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/carry5/part2 is too big.
         x = dynamic_params.mul_mod_row_ratio  - 
                dynamic_params.mul_mod_carry5_part2_suboffset * 
                dynamic_params.range_check_units_row_ratio
             -  1
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/carry5/part3 must be nonnegative.
         x = dynamic_params.mul_mod_carry5_part3_suboffset;
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/carry5/part3 is too big.
         x = trace_length - dynamic_params.mul_mod_carry5_part3_suboffset - 1;
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/carry5/part3 is too big.
         x = dynamic_params.mul_mod_row_ratio  - 
                dynamic_params.mul_mod_carry5_part3_suboffset * 
                dynamic_params.range_check_units_row_ratio
             -  1
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/carry5/part4 must be nonnegative.
         x = dynamic_params.mul_mod_carry5_part4_suboffset;
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/carry5/part4 is too big.
         x = trace_length - dynamic_params.mul_mod_carry5_part4_suboffset - 1;
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/carry5/part4 is too big.
         x = dynamic_params.mul_mod_row_ratio  - 
                dynamic_params.mul_mod_carry5_part4_suboffset * 
                dynamic_params.range_check_units_row_ratio
             -  1
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/carry5/part5 must be nonnegative.
         x = dynamic_params.mul_mod_carry5_part5_suboffset;
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/carry5/part5 is too big.
         x = trace_length - dynamic_params.mul_mod_carry5_part5_suboffset - 1;
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/carry5/part5 is too big.
         x = dynamic_params.mul_mod_row_ratio  - 
                dynamic_params.mul_mod_carry5_part5_suboffset * 
                dynamic_params.range_check_units_row_ratio
             -  1
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/carry5/part6 must be nonnegative.
         x = dynamic_params.mul_mod_carry5_part6_suboffset;
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/carry5/part6 is too big.
         x = trace_length - dynamic_params.mul_mod_carry5_part6_suboffset - 1;
        assert_range_u128_from_u256(x);
        
        // Offset of mul_mod/carry5/part6 is too big.
         x = dynamic_params.mul_mod_row_ratio  - 
                dynamic_params.mul_mod_carry5_part6_suboffset * 
                dynamic_params.range_check_units_row_ratio
             -  1
        assert_range_u128_from_u256(x);
    }
}
