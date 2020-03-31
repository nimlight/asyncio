import asyncdispatch, deques
import ./basic


func newAsyncCircularQueue*[Capacity: static[int], T](): AsyncCircularQueue[Capacity, T] =
  discard getGlobalDispatcher()
  new result
  result.getter = initDeque[Future[void]]()
  result.putter = initDeque[Future[void]]()

proc putNoWait*[T](q: AsyncCircularQueue, item: T) =
  if q.isFull:
    raise newException(FullQueueError, "Queue is full!")
