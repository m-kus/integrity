use cairo_verifier::air::layouts::starknet::global_values::GlobalValues;

#[starknet::interface]
trait IStarknetLayoutContract1<ContractState> {
    fn eval_composition_polynomial_inner(
        self: @ContractState,
        mask_values: Span<felt252>,
        constraint_coefficients: Span<felt252>,
        point: felt252,
        trace_generator: felt252,
        global_values: GlobalValues
    ) -> felt252;
}

#[starknet::interface]
trait IStarknetLayoutContract2<ContractState> {
    fn eval_oods_polynomial_inner(
        self: @ContractState,
        column_values: Span<felt252>,
        oods_values: Span<felt252>,
        constraint_coefficients: Span<felt252>,
        point: felt252,
        oods_point: felt252,
        trace_generator: felt252,
    ) -> felt252;
}

#[starknet::contract]
mod StarknetLayoutContract1 {
    use super::IStarknetLayoutContract1;
    use cairo_verifier::air::layouts::starknet::{
        global_values::GlobalValues,
        autogenerated::eval_composition_polynomial_inner,
    };

    #[storage]
    struct Storage {}

    #[abi(embed_v0)]
    impl StarknetLayoutContract1 of IStarknetLayoutContract1<ContractState> {
        fn eval_composition_polynomial_inner(
            self: @ContractState,
            mask_values: Span<felt252>,
            constraint_coefficients: Span<felt252>,
            point: felt252,
            trace_generator: felt252,
            global_values: GlobalValues
        ) -> felt252 {
            eval_composition_polynomial_inner(
                mask_values,
                constraint_coefficients,
                point,
                trace_generator,
                global_values
            )
        }
    }
}

#[starknet::contract]
mod StarknetLayoutContract2 {
    use super::IStarknetLayoutContract2;
    use cairo_verifier::air::layouts::starknet::{
        global_values::GlobalValues,
        autogenerated::eval_oods_polynomial_inner,
    };

    #[storage]
    struct Storage {}

    #[abi(embed_v0)]
    impl StarknetLayoutContract2 of IStarknetLayoutContract2<ContractState> {
        fn eval_oods_polynomial_inner(
            self: @ContractState,
            column_values: Span<felt252>,
            oods_values: Span<felt252>,
            constraint_coefficients: Span<felt252>,
            point: felt252,
            oods_point: felt252,
            trace_generator: felt252,
        ) -> felt252 {
            eval_oods_polynomial_inner(
                column_values,
                oods_values,
                constraint_coefficients,
                point,
                oods_point,
                trace_generator,
            )
        }
    }
}