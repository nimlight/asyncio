import deques, asyncdispatch


type
  FullQueueError* = object of ValueError
  EmptyQueueError* = object of ValueError

  CircularQueue*[Capacity: static[int], T] = ref object of RootObj
    data: array[Capacity, T]
    head, tail: int

  AsyncCircularQueue*[Capacity: static[int], T] = ref object of CircularQueue[Capacity, T]
    getter: Deque[Future[void]]
    putter: Deque[Future[void]]


func isFull*(q: CircularQueue | AsyncCircularQueue): bool {.inline.} =
  abs(q.tail-q.head) == q.Capacity

func isEmpty*(q: CircularQueue | AsyncCircularQueue): bool {.inline.} =
  q.tail == q.head

func len*(q: CircularQueue | AsyncCircularQueue): int {.inline.} =
  result = q.tail - q.head
  while result < 0:
    result.inc(q.Capacity)
