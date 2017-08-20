package Adylay;
use Mojo::Base 'Mojolicious';

use Adylay::Model::Ip;
use Adylay::Model::OpenVPN;

# This method will run once at server start
sub startup {
  my $self = shift;

  # Load configuration from hash returned by "Adylay.conf"
  my $config = $self->plugin('Config');

  # Documentation browser under "/perldoc"
  $self->plugin('PODRenderer') if $config->{perldoc};

  # Helper to lazy initialize and store our model object
  my $ipModel = Adylay::Model::Ip->new;
  my $vpnModel = Adylay::Model::OpenVPN->new($config->{openvpn_config_location});

  # Router
  my $router = $self->routes;

  # Normal route to controller
  $router->get('/')->to(template => 'home', 
    locationInfo => $ipModel->get(),
    files => $vpnModel->get());

  $router->get('/ip')->to(controller => 'ip', action => 'location', model => $ipModel);
  $router->get('/openvpn')->to(controller => 'openvpn', action => 'configuration', model => $vpnModel);
  $router->post('/openvpn/change')->to(controller => 'openvpn', action => 'change', model => $vpnModel);
}

1;
