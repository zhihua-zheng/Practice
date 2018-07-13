module type_gridpoint
  implicit none

  type gridpoint
    real, allocatable :: T(:,:), psi(:,:), u(:,:), v(:,:), x(:,:), y(:,:)
  end type gridpoint

end module type_gridpoint
