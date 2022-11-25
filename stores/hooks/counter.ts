import {useCallback, useMemo} from 'react';
import {useDispatch, useSelector} from 'react-redux';
import {RootState} from '..';
import {decrement, increment, incrementByAmount} from '../slices/counter';

type States = {
  count: number;
};
type Handlers = {
  useIncrement: () => void;
  useDecrement: () => void;
  useIncrementByAmount: (amount: number) => void;
};

export function useCounter(): [States, Handlers] {
  const count = useSelector((state: RootState) => state.counter.value);
  const dispatch = useDispatch();

  const useIncrement = useCallback(() => dispatch(increment()), [dispatch]);
  const useDecrement = useCallback(() => dispatch(decrement()), [dispatch]);
  const useIncrementByAmount = useCallback(
    (amount: number) => dispatch(incrementByAmount(amount)),
    [dispatch],
  );

  const memorizedState = useMemo(() => ({count}), [count]);
  const memorizedHandlers = useMemo(
    () => ({
      useIncrement,
      useDecrement,
      useIncrementByAmount,
    }),
    [useIncrement, useDecrement, useIncrementByAmount],
  );

  return [memorizedState, memorizedHandlers];
}
