package Adylay::Controller::Ip;

use Mojo::Base 'Mojolicious::Controller';

sub location {
  my $self = shift;
 
  my $model = $self->stash('model'); 
  $self->stash(locationInfo => $model->get());
  $self->render();
}

1;
