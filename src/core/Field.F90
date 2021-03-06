! Copyright (c) 2017 Matthew J. Smith and Overkit contributors
! License: MIT (http://opensource.org/licenses/MIT)

module ovkField

  use ovkCart
  use ovkGlobal
  implicit none

  private

  ! API
  public :: ovk_field_int
  public :: ovk_field_int_
  public :: ovk_field_large_int
  public :: ovk_field_large_int_
  public :: ovk_field_real
  public :: ovk_field_real_
  public :: ovk_field_logical
  public :: ovk_field_logical_
  public :: operator (==)
  public :: operator (/=)
  public :: ovkExportField

  type ovk_field_int
    type(ovk_cart) :: cart
    integer, dimension(:,:,:), allocatable :: values
  end type ovk_field_int

  type ovk_field_large_int
    type(ovk_cart) :: cart
    integer(lk), dimension(:,:,:), allocatable :: values
  end type ovk_field_large_int

  type ovk_field_real
    type(ovk_cart) :: cart
    real(rk), dimension(:,:,:), allocatable :: values
  end type ovk_field_real

  type ovk_field_logical
    type(ovk_cart) :: cart
    logical(bk), dimension(:,:,:), allocatable :: values
  end type ovk_field_logical

  ! Trailing _ added for compatibility with compilers that don't support F2003 constructors
  interface ovk_field_int_
    module procedure ovk_field_int_Default
    module procedure ovk_field_int_NoValues
    module procedure ovk_field_int_Values_Scalar
    module procedure ovk_field_int_Values_Rank2
    module procedure ovk_field_int_Values_Rank3
  end interface ovk_field_int_

  ! Trailing _ added for compatibility with compilers that don't support F2003 constructors
  interface ovk_field_large_int_
    module procedure ovk_field_large_int_Default
    module procedure ovk_field_large_int_NoValues
    module procedure ovk_field_large_int_Values_Scalar
    module procedure ovk_field_large_int_Values_Rank2
    module procedure ovk_field_large_int_Values_Rank3
  end interface ovk_field_large_int_

  ! Trailing _ added for compatibility with compilers that don't support F2003 constructors
  interface ovk_field_real_
    module procedure ovk_field_real_Default
    module procedure ovk_field_real_NoValues
    module procedure ovk_field_real_Values_Scalar
    module procedure ovk_field_real_Values_Rank2
    module procedure ovk_field_real_Values_Rank3
  end interface ovk_field_real_

  ! Trailing _ added for compatibility with compilers that don't support F2003 constructors
  interface ovk_field_logical_
    module procedure ovk_field_logical_Default
    module procedure ovk_field_logical_NoValues
    module procedure ovk_field_logical_Values_Scalar
    module procedure ovk_field_logical_Values_Rank2
    module procedure ovk_field_logical_Values_Rank3
    module procedure ovk_field_logical_Values_Scalar_1Byte
    module procedure ovk_field_logical_Values_Rank2_1Byte
    module procedure ovk_field_logical_Values_Rank3_1Byte
  end interface ovk_field_logical_

  interface operator (==)
    module procedure ovk_field_int_Equal
    module procedure ovk_field_large_int_Equal
    module procedure ovk_field_real_Equal
    module procedure ovk_field_logical_Equal
  end interface operator (==)

  interface operator (/=)
    module procedure ovk_field_int_NotEqual
    module procedure ovk_field_large_int_NotEqual
    module procedure ovk_field_real_NotEqual
    module procedure ovk_field_logical_NotEqual
  end interface operator (/=)

  interface ovkExportField
    module procedure ovkExportField_Integer_Rank2
    module procedure ovkExportField_Integer_Rank3
    module procedure ovkExportField_LargeInteger_Rank2
    module procedure ovkExportField_LargeInteger_Rank3
    module procedure ovkExportField_Real_Rank2
    module procedure ovkExportField_Real_Rank3
    module procedure ovkExportField_Logical_Rank2
    module procedure ovkExportField_Logical_Rank3
    module procedure ovkExportField_Logical_Rank2_1Byte
    module procedure ovkExportField_Logical_Rank3_1Byte
  end interface ovkExportField

contains

  pure function ovk_field_int_Default(nDims) result(Field)

    integer, intent(in) :: nDims
    type(ovk_field_int) :: Field

    Field%cart = ovk_cart_(nDims)

  end function ovk_field_int_Default

  pure function ovk_field_large_int_Default(nDims) result(Field)

    integer, intent(in) :: nDims
    type(ovk_field_large_int) :: Field

    Field%cart = ovk_cart_(nDims)

  end function ovk_field_large_int_Default

  pure function ovk_field_real_Default(nDims) result(Field)

    integer, intent(in) :: nDims
    type(ovk_field_real) :: Field

    Field%cart = ovk_cart_(nDims)

  end function ovk_field_real_Default

  pure function ovk_field_logical_Default(nDims) result(Field)

    integer, intent(in) :: nDims
    type(ovk_field_logical) :: Field

    Field%cart = ovk_cart_(nDims)

  end function ovk_field_logical_Default

  pure function ovk_field_int_NoValues(Cart) result(Field)

    type(ovk_cart), intent(in) :: Cart
    type(ovk_field_int) :: Field

    Field%cart = ovkCartConvertPeriodicStorage(Cart, OVK_NO_OVERLAP_PERIODIC)

    allocate(Field%values(Field%cart%is(1):Field%cart%ie(1),Field%cart%is(2):Field%cart%ie(2), &
      Field%cart%is(3):Field%cart%ie(3)))

  end function ovk_field_int_NoValues

  pure function ovk_field_large_int_NoValues(Cart) result(Field)

    type(ovk_cart), intent(in) :: Cart
    type(ovk_field_large_int) :: Field

    Field%cart = ovkCartConvertPeriodicStorage(Cart, OVK_NO_OVERLAP_PERIODIC)

    allocate(Field%values(Field%cart%is(1):Field%cart%ie(1),Field%cart%is(2):Field%cart%ie(2), &
      Field%cart%is(3):Field%cart%ie(3)))

  end function ovk_field_large_int_NoValues

  pure function ovk_field_real_NoValues(Cart) result(Field)

    type(ovk_cart), intent(in) :: Cart
    type(ovk_field_real) :: Field

    Field%cart = ovkCartConvertPeriodicStorage(Cart, OVK_NO_OVERLAP_PERIODIC)

    allocate(Field%values(Field%cart%is(1):Field%cart%ie(1),Field%cart%is(2):Field%cart%ie(2), &
      Field%cart%is(3):Field%cart%ie(3)))

  end function ovk_field_real_NoValues

  pure function ovk_field_logical_NoValues(Cart) result(Field)

    type(ovk_cart), intent(in) :: Cart
    type(ovk_field_logical) :: Field

    Field%cart = ovkCartConvertPeriodicStorage(Cart, OVK_NO_OVERLAP_PERIODIC)

    allocate(Field%values(Field%cart%is(1):Field%cart%ie(1),Field%cart%is(2):Field%cart%ie(2), &
      Field%cart%is(3):Field%cart%ie(3)))

  end function ovk_field_logical_NoValues

  pure function ovk_field_int_Values_Scalar(Cart, Value) result(Field)

    type(ovk_cart), intent(in) :: Cart
    integer, intent(in) :: Value
    type(ovk_field_int) :: Field

    Field%cart = ovkCartConvertPeriodicStorage(Cart, OVK_NO_OVERLAP_PERIODIC)

    allocate(Field%values(Field%cart%is(1):Field%cart%ie(1),Field%cart%is(2):Field%cart%ie(2), &
      Field%cart%is(3):Field%cart%ie(3)))

    Field%values = Value

  end function ovk_field_int_Values_Scalar

  pure function ovk_field_large_int_Values_Scalar(Cart, Value) result(Field)

    type(ovk_cart), intent(in) :: Cart
    integer(lk), intent(in) :: Value
    type(ovk_field_large_int) :: Field

    Field%cart = ovkCartConvertPeriodicStorage(Cart, OVK_NO_OVERLAP_PERIODIC)

    allocate(Field%values(Field%cart%is(1):Field%cart%ie(1),Field%cart%is(2):Field%cart%ie(2), &
      Field%cart%is(3):Field%cart%ie(3)))

    Field%values = Value

  end function ovk_field_large_int_Values_Scalar

  pure function ovk_field_real_Values_Scalar(Cart, Value) result(Field)

    type(ovk_cart), intent(in) :: Cart
    real(rk), intent(in) :: Value
    type(ovk_field_real) :: Field

    Field%cart = ovkCartConvertPeriodicStorage(Cart, OVK_NO_OVERLAP_PERIODIC)

    allocate(Field%values(Field%cart%is(1):Field%cart%ie(1),Field%cart%is(2):Field%cart%ie(2), &
      Field%cart%is(3):Field%cart%ie(3)))

    Field%values = Value

  end function ovk_field_real_Values_Scalar

  pure function ovk_field_logical_Values_Scalar(Cart, Value) result(Field)

    type(ovk_cart), intent(in) :: Cart
    logical, intent(in) :: Value
    type(ovk_field_logical) :: Field

    Field%cart = ovkCartConvertPeriodicStorage(Cart, OVK_NO_OVERLAP_PERIODIC)

    allocate(Field%values(Field%cart%is(1):Field%cart%ie(1),Field%cart%is(2):Field%cart%ie(2), &
      Field%cart%is(3):Field%cart%ie(3)))

    Field%values = Value

  end function ovk_field_logical_Values_Scalar

  pure function ovk_field_logical_Values_Scalar_1Byte(Cart, Value) result(Field)

    type(ovk_cart), intent(in) :: Cart
    logical(bk), intent(in) :: Value
    type(ovk_field_logical) :: Field

    Field%cart = ovkCartConvertPeriodicStorage(Cart, OVK_NO_OVERLAP_PERIODIC)

    allocate(Field%values(Field%cart%is(1):Field%cart%ie(1),Field%cart%is(2):Field%cart%ie(2), &
      Field%cart%is(3):Field%cart%ie(3)))

    Field%values = Value

  end function ovk_field_logical_Values_Scalar_1Byte

  pure function ovk_field_int_Values_Rank2(Cart, Values) result(Field)

    type(ovk_cart), intent(in) :: Cart
    integer, dimension(:,:), intent(in) :: Values
    type(ovk_field_int) :: Field

    Field%cart = ovkCartConvertPeriodicStorage(Cart, OVK_NO_OVERLAP_PERIODIC)

    allocate(Field%values(Field%cart%is(1):Field%cart%ie(1),Field%cart%is(2):Field%cart%ie(2), &
      Field%cart%is(3):Field%cart%ie(3)))

    Field%values(:,:,1) = Values(:Field%cart%ie(1)-Field%cart%is(1)+1, &
      :Field%cart%ie(2)-Field%cart%is(2)+1)

  end function ovk_field_int_Values_Rank2

  pure function ovk_field_large_int_Values_Rank2(Cart, Values) result(Field)

    type(ovk_cart), intent(in) :: Cart
    integer(lk), dimension(:,:), intent(in) :: Values
    type(ovk_field_large_int) :: Field

    Field%cart = ovkCartConvertPeriodicStorage(Cart, OVK_NO_OVERLAP_PERIODIC)

    allocate(Field%values(Field%cart%is(1):Field%cart%ie(1),Field%cart%is(2):Field%cart%ie(2), &
      Field%cart%is(3):Field%cart%ie(3)))

    Field%values(:,:,1) = Values(:Field%cart%ie(1)-Field%cart%is(1)+1, &
      :Field%cart%ie(2)-Field%cart%is(2)+1)

  end function ovk_field_large_int_Values_Rank2

  pure function ovk_field_real_Values_Rank2(Cart, Values) result(Field)

    type(ovk_cart), intent(in) :: Cart
    real(rk), dimension(:,:), intent(in) :: Values
    type(ovk_field_real) :: Field

    Field%cart = ovkCartConvertPeriodicStorage(Cart, OVK_NO_OVERLAP_PERIODIC)

    allocate(Field%values(Field%cart%is(1):Field%cart%ie(1),Field%cart%is(2):Field%cart%ie(2), &
      Field%cart%is(3):Field%cart%ie(3)))

    Field%values(:,:,1) = Values(:Field%cart%ie(1)-Field%cart%is(1)+1, &
      :Field%cart%ie(2)-Field%cart%is(2)+1)

  end function ovk_field_real_Values_Rank2

  pure function ovk_field_logical_Values_Rank2(Cart, Values) result(Field)

    type(ovk_cart), intent(in) :: Cart
    logical, dimension(:,:), intent(in) :: Values
    type(ovk_field_logical) :: Field

    Field%cart = ovkCartConvertPeriodicStorage(Cart, OVK_NO_OVERLAP_PERIODIC)

    allocate(Field%values(Field%cart%is(1):Field%cart%ie(1),Field%cart%is(2):Field%cart%ie(2), &
      Field%cart%is(3):Field%cart%ie(3)))

    Field%values(:,:,1) = Values(:Field%cart%ie(1)-Field%cart%is(1)+1, &
      :Field%cart%ie(2)-Field%cart%is(2)+1)

  end function ovk_field_logical_Values_Rank2

  pure function ovk_field_logical_Values_Rank2_1Byte(Cart, Values) result(Field)

    type(ovk_cart), intent(in) :: Cart
    logical(bk), dimension(:,:), intent(in) :: Values
    type(ovk_field_logical) :: Field

    Field%cart = ovkCartConvertPeriodicStorage(Cart, OVK_NO_OVERLAP_PERIODIC)

    allocate(Field%values(Field%cart%is(1):Field%cart%ie(1),Field%cart%is(2):Field%cart%ie(2), &
      Field%cart%is(3):Field%cart%ie(3)))

    Field%values(:,:,1) = Values(:Field%cart%ie(1)-Field%cart%is(1)+1, &
      :Field%cart%ie(2)-Field%cart%is(2)+1)

  end function ovk_field_logical_Values_Rank2_1Byte

  pure function ovk_field_int_Values_Rank3(Cart, Values) result(Field)

    type(ovk_cart), intent(in) :: Cart
    integer, dimension(:,:,:), intent(in) :: Values
    type(ovk_field_int) :: Field

    Field%cart = ovkCartConvertPeriodicStorage(Cart, OVK_NO_OVERLAP_PERIODIC)

    allocate(Field%values(Field%cart%is(1):Field%cart%ie(1),Field%cart%is(2):Field%cart%ie(2), &
      Field%cart%is(3):Field%cart%ie(3)))

    Field%values = Values(:Field%cart%ie(1)-Field%cart%is(1)+1, &
      :Field%cart%ie(2)-Field%cart%is(2)+1,:Field%cart%ie(3)-Field%cart%is(3)+1)

  end function ovk_field_int_Values_Rank3

  pure function ovk_field_large_int_Values_Rank3(Cart, Values) result(Field)

    type(ovk_cart), intent(in) :: Cart
    integer(lk), dimension(:,:,:), intent(in) :: Values
    type(ovk_field_large_int) :: Field

    Field%cart = ovkCartConvertPeriodicStorage(Cart, OVK_NO_OVERLAP_PERIODIC)

    allocate(Field%values(Field%cart%is(1):Field%cart%ie(1),Field%cart%is(2):Field%cart%ie(2), &
      Field%cart%is(3):Field%cart%ie(3)))

    Field%values = Values(:Field%cart%ie(1)-Field%cart%is(1)+1, &
      :Field%cart%ie(2)-Field%cart%is(2)+1,:Field%cart%ie(3)-Field%cart%is(3)+1)

  end function ovk_field_large_int_Values_Rank3

  pure function ovk_field_real_Values_Rank3(Cart, Values) result(Field)

    type(ovk_cart), intent(in) :: Cart
    real(rk), dimension(:,:,:), intent(in) :: Values
    type(ovk_field_real) :: Field

    Field%cart = ovkCartConvertPeriodicStorage(Cart, OVK_NO_OVERLAP_PERIODIC)

    allocate(Field%values(Field%cart%is(1):Field%cart%ie(1),Field%cart%is(2):Field%cart%ie(2), &
      Field%cart%is(3):Field%cart%ie(3)))

    Field%values = Values(:Field%cart%ie(1)-Field%cart%is(1)+1, &
      :Field%cart%ie(2)-Field%cart%is(2)+1,:Field%cart%ie(3)-Field%cart%is(3)+1)

  end function ovk_field_real_Values_Rank3

  pure function ovk_field_logical_Values_Rank3(Cart, Values) result(Field)

    type(ovk_cart), intent(in) :: Cart
    logical, dimension(:,:,:), intent(in) :: Values
    type(ovk_field_logical) :: Field

    Field%cart = ovkCartConvertPeriodicStorage(Cart, OVK_NO_OVERLAP_PERIODIC)

    allocate(Field%values(Field%cart%is(1):Field%cart%ie(1),Field%cart%is(2):Field%cart%ie(2), &
      Field%cart%is(3):Field%cart%ie(3)))

    Field%values = Values(:Field%cart%ie(1)-Field%cart%is(1)+1, &
      :Field%cart%ie(2)-Field%cart%is(2)+1,:Field%cart%ie(3)-Field%cart%is(3)+1)

  end function ovk_field_logical_Values_Rank3

  pure function ovk_field_logical_Values_Rank3_1Byte(Cart, Values) result(Field)

    type(ovk_cart), intent(in) :: Cart
    logical(bk), dimension(:,:,:), intent(in) :: Values
    type(ovk_field_logical) :: Field

    Field%cart = ovkCartConvertPeriodicStorage(Cart, OVK_NO_OVERLAP_PERIODIC)

    allocate(Field%values(Field%cart%is(1):Field%cart%ie(1),Field%cart%is(2):Field%cart%ie(2), &
      Field%cart%is(3):Field%cart%ie(3)))

    Field%values = Values(:Field%cart%ie(1)-Field%cart%is(1)+1, &
      :Field%cart%ie(2)-Field%cart%is(2)+1,:Field%cart%ie(3)-Field%cart%is(3)+1)

  end function ovk_field_logical_Values_Rank3_1Byte

  pure function ovk_field_int_Equal(LeftField, RightField) result(Equal)

    type(ovk_field_int), intent(in) :: LeftField, RightField
    logical :: Equal

    Equal = LeftField%cart == RightField%cart

    if (Equal .and. all(LeftField%cart%ie >= LeftField%cart%is)) then
      Equal = Equal .and. all(LeftField%values == RightField%values)
    end if

  end function ovk_field_int_Equal

  pure function ovk_field_large_int_Equal(LeftField, RightField) result(Equal)

    type(ovk_field_large_int), intent(in) :: LeftField, RightField
    logical :: Equal

    Equal = LeftField%cart == RightField%cart

    if (Equal .and. all(LeftField%cart%ie >= LeftField%cart%is)) then
      Equal = Equal .and. all(LeftField%values == RightField%values)
    end if

  end function ovk_field_large_int_Equal

  pure function ovk_field_real_Equal(LeftField, RightField) result(Equal)

    type(ovk_field_real), intent(in) :: LeftField, RightField
    logical :: Equal

    Equal = LeftField%cart == RightField%cart

    if (Equal .and. all(LeftField%cart%ie >= LeftField%cart%is)) then
      Equal = Equal .and. all(LeftField%values == RightField%values)
    end if

  end function ovk_field_real_Equal

  pure function ovk_field_logical_Equal(LeftField, RightField) result(Equal)

    type(ovk_field_logical), intent(in) :: LeftField, RightField
    logical :: Equal

    Equal = LeftField%cart == RightField%cart

    if (Equal .and. all(LeftField%cart%ie >= LeftField%cart%is)) then
      Equal = Equal .and. all(LeftField%values .eqv. RightField%values)
    end if

  end function ovk_field_logical_Equal

  pure function ovk_field_int_NotEqual(LeftField, RightField) result(NotEqual)

    type(ovk_field_int), intent(in) :: LeftField, RightField
    logical :: NotEqual

    NotEqual = .not. ovk_field_int_Equal(LeftField, RightField)

  end function ovk_field_int_NotEqual

  pure function ovk_field_large_int_NotEqual(LeftField, RightField) result(NotEqual)

    type(ovk_field_large_int), intent(in) :: LeftField, RightField
    logical :: NotEqual

    NotEqual = .not. ovk_field_large_int_Equal(LeftField, RightField)

  end function ovk_field_large_int_NotEqual

  pure function ovk_field_real_NotEqual(LeftField, RightField) result(NotEqual)

    type(ovk_field_real), intent(in) :: LeftField, RightField
    logical :: NotEqual

    NotEqual = .not. ovk_field_real_Equal(LeftField, RightField)

  end function ovk_field_real_NotEqual

  pure function ovk_field_logical_NotEqual(LeftField, RightField) result(NotEqual)

    type(ovk_field_logical), intent(in) :: LeftField, RightField
    logical :: NotEqual

    NotEqual = .not. ovk_field_logical_Equal(LeftField, RightField)

  end function ovk_field_logical_NotEqual

  subroutine ovkExportField_Integer_Rank2(Field, ExportCart, Values)

    type(ovk_field_int), intent(in) :: Field
    type(ovk_cart), intent(in) :: ExportCart
    integer, dimension(:,:), intent(out) :: Values

    integer :: i, j, m, n
    integer, dimension(MAX_ND) :: Point

    do j = ExportCart%is(2), ExportCart%ie(2)
      do i = ExportCart%is(1), ExportCart%ie(1)
        Point = [i,j,1]
        Point(:Field%cart%nd) = ovkCartPeriodicAdjust(Field%cart, Point)
        m = i-ExportCart%is(1)+1
        n = j-ExportCart%is(2)+1
        Values(m,n) = Field%values(Point(1),Point(2),Point(3))
      end do
    end do

  end subroutine ovkExportField_Integer_Rank2

  subroutine ovkExportField_Integer_Rank3(Field, ExportCart, Values)

    type(ovk_field_int), intent(in) :: Field
    type(ovk_cart), intent(in) :: ExportCart
    integer, dimension(:,:,:), intent(out) :: Values

    integer :: i, j, k, m, n, o
    integer, dimension(MAX_ND) :: Point

    do k = ExportCart%is(3), ExportCart%ie(3)
      do j = ExportCart%is(2), ExportCart%ie(2)
        do i = ExportCart%is(1), ExportCart%ie(1)
          Point = [i,j,k]
          Point(:Field%cart%nd) = ovkCartPeriodicAdjust(Field%cart, Point)
          m = i-ExportCart%is(1)+1
          n = j-ExportCart%is(2)+1
          o = k-ExportCart%is(3)+1
          Values(m,n,o) = Field%values(Point(1),Point(2),Point(3))
        end do
      end do
    end do

  end subroutine ovkExportField_Integer_Rank3

  subroutine ovkExportField_LargeInteger_Rank2(Field, ExportCart, Values)

    type(ovk_field_large_int), intent(in) :: Field
    type(ovk_cart), intent(in) :: ExportCart
    integer(lk), dimension(:,:), intent(out) :: Values

    integer :: i, j, m, n
    integer, dimension(MAX_ND) :: Point

    do j = ExportCart%is(2), ExportCart%ie(2)
      do i = ExportCart%is(1), ExportCart%ie(1)
        Point = [i,j,1]
        Point(:Field%cart%nd) = ovkCartPeriodicAdjust(Field%cart, Point)
        m = i-ExportCart%is(1)+1
        n = j-ExportCart%is(2)+1
        Values(m,n) = Field%values(Point(1),Point(2),Point(3))
      end do
    end do

  end subroutine ovkExportField_LargeInteger_Rank2

  subroutine ovkExportField_LargeInteger_Rank3(Field, ExportCart, Values)

    type(ovk_field_large_int), intent(in) :: Field
    type(ovk_cart), intent(in) :: ExportCart
    integer(lk), dimension(:,:,:), intent(out) :: Values

    integer :: i, j, k, m, n, o
    integer, dimension(MAX_ND) :: Point

    do k = ExportCart%is(3), ExportCart%ie(3)
      do j = ExportCart%is(2), ExportCart%ie(2)
        do i = ExportCart%is(1), ExportCart%ie(1)
          Point = [i,j,k]
          Point(:Field%cart%nd) = ovkCartPeriodicAdjust(Field%cart, Point)
          m = i-ExportCart%is(1)+1
          n = j-ExportCart%is(2)+1
          o = k-ExportCart%is(3)+1
          Values(m,n,o) = Field%values(Point(1),Point(2),Point(3))
        end do
      end do
    end do

  end subroutine ovkExportField_LargeInteger_Rank3

  subroutine ovkExportField_Real_Rank2(Field, ExportCart, Values)

    type(ovk_field_real), intent(in) :: Field
    type(ovk_cart), intent(in) :: ExportCart
    real(rk), dimension(:,:), intent(out) :: Values

    integer :: i, j, m, n
    integer, dimension(MAX_ND) :: Point

    do j = ExportCart%is(2), ExportCart%ie(2)
      do i = ExportCart%is(1), ExportCart%ie(1)
        Point = [i,j,1]
        Point(:Field%cart%nd) = ovkCartPeriodicAdjust(Field%cart, Point)
        m = i-ExportCart%is(1)+1
        n = j-ExportCart%is(2)+1
        Values(m,n) = Field%values(Point(1),Point(2),Point(3))
      end do
    end do

  end subroutine ovkExportField_Real_Rank2

  subroutine ovkExportField_Real_Rank3(Field, ExportCart, Values)

    type(ovk_field_real), intent(in) :: Field
    type(ovk_cart), intent(in) :: ExportCart
    real(rk), dimension(:,:,:), intent(out) :: Values

    integer :: i, j, k, m, n, o
    integer, dimension(MAX_ND) :: Point

    do k = ExportCart%is(3), ExportCart%ie(3)
      do j = ExportCart%is(2), ExportCart%ie(2)
        do i = ExportCart%is(1), ExportCart%ie(1)
          Point = [i,j,k]
          Point(:Field%cart%nd) = ovkCartPeriodicAdjust(Field%cart, Point)
          m = i-ExportCart%is(1)+1
          n = j-ExportCart%is(2)+1
          o = k-ExportCart%is(3)+1
          Values(m,n,o) = Field%values(Point(1),Point(2),Point(3))
        end do
      end do
    end do

  end subroutine ovkExportField_Real_Rank3

  subroutine ovkExportField_Logical_Rank2(Field, ExportCart, Values)

    type(ovk_field_logical), intent(in) :: Field
    type(ovk_cart), intent(in) :: ExportCart
    logical, dimension(:,:), intent(out) :: Values

    integer :: i, j, m, n
    integer, dimension(MAX_ND) :: Point

    do j = ExportCart%is(2), ExportCart%ie(2)
      do i = ExportCart%is(1), ExportCart%ie(1)
        Point = [i,j,1]
        Point(:Field%cart%nd) = ovkCartPeriodicAdjust(Field%cart, Point)
        m = i-ExportCart%is(1)+1
        n = j-ExportCart%is(2)+1
        Values(m,n) = Field%values(Point(1),Point(2),Point(3))
      end do
    end do

  end subroutine ovkExportField_Logical_Rank2

  subroutine ovkExportField_Logical_Rank3(Field, ExportCart, Values)

    type(ovk_field_logical), intent(in) :: Field
    type(ovk_cart), intent(in) :: ExportCart
    logical, dimension(:,:,:), intent(out) :: Values

    integer :: i, j, k, m, n, o
    integer, dimension(MAX_ND) :: Point

    do k = ExportCart%is(3), ExportCart%ie(3)
      do j = ExportCart%is(2), ExportCart%ie(2)
        do i = ExportCart%is(1), ExportCart%ie(1)
          Point = [i,j,k]
          Point(:Field%cart%nd) = ovkCartPeriodicAdjust(Field%cart, Point)
          m = i-ExportCart%is(1)+1
          n = j-ExportCart%is(2)+1
          o = k-ExportCart%is(3)+1
          Values(m,n,o) = Field%values(Point(1),Point(2),Point(3))
        end do
      end do
    end do

  end subroutine ovkExportField_Logical_Rank3

  subroutine ovkExportField_Logical_Rank2_1Byte(Field, ExportCart, Values)

    type(ovk_field_logical), intent(in) :: Field
    type(ovk_cart), intent(in) :: ExportCart
    logical(bk), dimension(:,:), intent(out) :: Values

    integer :: i, j, m, n
    integer, dimension(MAX_ND) :: Point

    do j = ExportCart%is(2), ExportCart%ie(2)
      do i = ExportCart%is(1), ExportCart%ie(1)
        Point = [i,j,1]
        Point(:Field%cart%nd) = ovkCartPeriodicAdjust(Field%cart, Point)
        m = i-ExportCart%is(1)+1
        n = j-ExportCart%is(2)+1
        Values(m,n) = Field%values(Point(1),Point(2),Point(3))
      end do
    end do

  end subroutine ovkExportField_Logical_Rank2_1Byte

  subroutine ovkExportField_Logical_Rank3_1Byte(Field, ExportCart, Values)

    type(ovk_field_logical), intent(in) :: Field
    type(ovk_cart), intent(in) :: ExportCart
    logical(bk), dimension(:,:,:), intent(out) :: Values

    integer :: i, j, k, m, n, o
    integer, dimension(MAX_ND) :: Point

    do k = ExportCart%is(3), ExportCart%ie(3)
      do j = ExportCart%is(2), ExportCart%ie(2)
        do i = ExportCart%is(1), ExportCart%ie(1)
          Point = [i,j,k]
          Point(:Field%cart%nd) = ovkCartPeriodicAdjust(Field%cart, Point)
          m = i-ExportCart%is(1)+1
          n = j-ExportCart%is(2)+1
          o = k-ExportCart%is(3)+1
          Values(m,n,o) = Field%values(Point(1),Point(2),Point(3))
        end do
      end do
    end do

  end subroutine ovkExportField_Logical_Rank3_1Byte

end module ovkField
