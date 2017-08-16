package Adylay::Controller::Openvpn;

use Mojo::Base 'Mojolicious::Controller';
use Mojo::JSON;

sub configuration {
  my $self = shift;

  my $model = $self->stash('model');
  my @files = $model->get();

  if (@files) {
    $self->stash(files => @files);
    $self->render();
  }
  else {
    $self->render(text => 'Failed to find configuration', status => 404);
  }
}

1;
