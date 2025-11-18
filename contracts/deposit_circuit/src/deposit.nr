use dep::merkle_trees::compute_merkle_root;
use dep::std::hash::pedersen_hash;

fn main(
    id: Field,
    r: Field,
    oldPath: [Field; 8],
    oldRoot: pub Field,
    newRoot: pub Field,
    commitment: pub Field,
    index: pub Field,
) {
    assert(commitment == pedersen_hash([id, r]));

    let oldLeaf = 0x2df8b940e5890e4e1377e05373fae69a1d754f6935e6a780b666947431f2cdcd;
    assert(
        oldRoot == compute_merkle_root(oldLeaf, index, oldPath)
    );

    assert(
        newRoot == compute_merkle_root(commitment, index, oldPath)
    );

   
}