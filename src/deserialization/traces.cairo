use core::traits::Into;
use cairo_verifier::{
    air::{
        traces_config::TracesConfig,
        traces::{TracesUnsentCommitment, TracesDecommitment, TracesWitness}
    },
    deserialization::{
        vector::{
            VectorCommitmentConfig, VectorCommitmentWitness, VectorCommitmentConfigWithSerde,
            VectorCommitmentWitnessWithSerde
        },
        table::{
            TableCommitmentConfigWithSerde, TableDecommitmentWithSerde,
            TableCommitmentWitnessWithSerde, TableUnsentCommitmentWithSerde
        }
    },
};

#[derive(Drop, Serde)]
struct TracesConfigWithSerde {
    original: TableCommitmentConfigWithSerde,
    interaction: TableCommitmentConfigWithSerde,
}
impl IntoTracesConfig of Into<TracesConfigWithSerde, TracesConfig> {
    fn into(self: TracesConfigWithSerde) -> TracesConfig {
        TracesConfig { original: self.original.into(), interaction: self.interaction.into(), }
    }
}

#[derive(Drop, Serde)]
struct TracesDecommitmentWithSerde {
    original: TableDecommitmentWithSerde,
    interaction: TableDecommitmentWithSerde,
}
impl IntoTracesDecommitment of Into<TracesDecommitmentWithSerde, TracesDecommitment> {
    fn into(self: TracesDecommitmentWithSerde) -> TracesDecommitment {
        TracesDecommitment { original: self.original.into(), interaction: self.interaction.into(), }
    }
}

#[derive(Drop, Serde)]
struct TracesUnsentCommitmentWithSerde {
    original: TableUnsentCommitmentWithSerde,
    interaction: TableUnsentCommitmentWithSerde,
}
impl IntoTracesUnsentCommitment of Into<TracesUnsentCommitmentWithSerde, TracesUnsentCommitment> {
    fn into(self: TracesUnsentCommitmentWithSerde) -> TracesUnsentCommitment {
        TracesUnsentCommitment {
            original: self.original.into(), interaction: self.interaction.into(),
        }
    }
}

#[derive(Drop, Serde)]
struct TracesWitnessWithSerde {
    original: TableCommitmentWitnessWithSerde,
    interaction: TableCommitmentWitnessWithSerde,
}
impl IntoTracesWitness of Into<TracesWitnessWithSerde, TracesWitness> {
    fn into(self: TracesWitnessWithSerde) -> TracesWitness {
        TracesWitness { original: self.original.into(), interaction: self.interaction.into(), }
    }
}

