(define (double x) (+ x x))

(define (make-point x y) (cons x y))
(define (x-point point) (car point))
(define (y-point point) (cdr point))

(define (make-rectangle1 point width height)
  (cons point (cons width height)))

(define (width-rectangle1 rectangle) (car (cdr rectangle)))
(define (height-rectangle1 rectangle) (cdr (cdr rectangle)))

(define (a-rectangle1 rectangle)
  (let ((x (x-point (b-rectangle rectangle)))
        (y (- (y-point (b-rectangle rectangle))
              (height-rectangle rectangle))))
    (make-point x y)))

(define (b-rectangle1 rectangle) (car rectangle))

(define (c-rectangle1 rectangle)
  (let ((x (+ (x-point (b-rectangle rectangle))
              (width-rectangle rectangle)))
        (y (y-point (b-rectangle rectangle))))
    (make-point x y)))

(define (d-rectangle1 rectangle)
  (let ((x (+ (x-point (b-rectangle rectangle))
              (width-rectangle rectangle)))
        (y (- (y-point (b-rectangle rectangle))
              (height-rectangle rectangle))))
    (make-point x y)))

(define (perimeter-rectangle1 rectangle)
  (+ (double (width-rectangle1 rectangle))
     (double (height-rectangle1 rectangle))))

(define (area-rectangle1 rectangle)
  (* (width-rectangle1 rectangle)
     (height-rectangle1 rectangle)))

(define (make-rectangle2 b d) (cons b d))

(define (width-rectangle2 rectangle) 
  (- (x-point (cdr rectangle))
     (x-point (car rectangle))))

(define (height-rectangle2 rectangle)
  (- (y-point (car rectangle))
     (y-point (cdr rectangle))))

(define (a-rectangle2 rectangle)
  (let ((x (x-point (b-rectangle rectangle)))
        (y (y-point (d-rectangle rectangle))))
    (make-point x y)))

(define (b-rectangle2 rectangle) (car rectangle))

(define (c-rectangle2 rectangle)
  (let ((x (x-point (d-rectangle rectangle)))
        (y (y-point (b-rectangle rectangle))))
    (make-point x y)))

(define (d-rectangle2 rectangle) (cdr rectangle))

(define (perimeter-rectangle2 rectangle)
  (+ (double (width-rectangle2 rectangle))
     (double (height-rectangle2 rectangle))))

(define (area-rectangle2 rectangle)
  (* (width-rectangle2 rectangle)
     (height-rectangle2 rectangle)))

