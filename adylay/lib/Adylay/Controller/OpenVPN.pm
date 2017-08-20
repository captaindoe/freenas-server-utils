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

sub change {
  my $self = shift;
  my $model = $self->stash('model');
  my $selection = $self->req->body_params->param('config');
  my $successful = $model->update($selection);
  if ($successful) {
    $self->flash(selection => $selection);
  } else {
    $self->flash(error => 'Failed to update config.');
  }
  $self->redirect_to('/');
}

1;
