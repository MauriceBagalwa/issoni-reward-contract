use starknet::ContractAddress;


#[starknet::interface]
pub trait I_REWARD<T> {
    fn add_points(ref self: T, _point: u64);
    fn redeem_points(ref self: T, _from: ContractAddress, _to: ContractAddress, _point: u64);
    fn balance(self: @T) -> u64;
}


#[starknet::contract]
mod IT_REWARD {
    use starknet::event::EventEmitter;
    use core::starknet::storage::{
        StoragePointerReadAccess, StoragePointerWriteAccess, StoragePathEntry, Map,
    };
    use core::starknet::{ContractAddress, get_caller_address};

    #[storage]
    struct Storage {
        user_points: Map<ContractAddress, u64>,
    }

    #[event]
    #[derive(Drop, starknet::Event)]
    pub enum Event {
        PointAdded: PointAdded,
        PointReDeen: PointReDeen,
    }

    #[derive(Drop, starknet::Event)]
    pub struct PointAdded {
        #[key]
        _to: ContractAddress,
        _point: u64,
    }

    #[derive(Drop, starknet::Event)]
    pub struct PointReDeen {
        #[key]
        _from: ContractAddress,
        _to: ContractAddress,
        _point: u64,
    }

    #[abi(embed_v0)]
    impl IT_REWARD of super::I_REWARD<ContractState> {
        //
        fn add_points(ref self: ContractState, _point: u64) {
            // -::-
            assert(_point < 1 || _point > 50, 'Point is out of range (1...50)');

            // -::-
            let caller = get_caller_address();
            let current_point = get_current_point(@self, caller);

            // -::-
            self.user_points.entry(caller).write(current_point + _point);
            self.emit(PointAdded { _to: caller, _point });
        }

        fn redeem_points(
            ref self: ContractState, _from: ContractAddress, _to: ContractAddress, _point: u64,
        ) {
            // -::-
            let sender_point = get_current_point(@self, _from);
            assert(sender_point >= _point, 'Insufficient points');

            // -::-
            self.user_points.entry(_from).write(sender_point - _point);
            self.user_points.entry(_to).write(get_current_point(@self, _to) + _point);

            // -::- Make event
            self.emit(PointReDeen { _to, _from, _point });
        }

        fn balance(self: @ContractState) -> u64 {
            // -::-
            let caller = get_caller_address();
            get_current_point(self, caller)
        }
    }

    fn get_current_point(self: @ContractState, address: ContractAddress) -> u64 {
        // -::-
        self.user_points.entry(address).read()
    }
}
