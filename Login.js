/**
* Copyright (c) 2015-present, Facebook, Inc. All rights reserved.
*
* You are hereby granted a non-exclusive, worldwide, royalty-free license to use,
* copy, modify, and distribute this software in source code or binary form for use
* in connection with the web services and APIs provided by Facebook.
*
* As with any software that integrates with the Facebook platform, your use of
* this software is subject to the Facebook Developer Principles and Policies
* [http://developers.facebook.com/policy/]. This copyright notice shall be
* included in all copies or substantial portions of the software.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
* FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
* COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
* IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
* CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*/

'use strict';

var React = require('react-native');
var {
  Text,
  StyleSheet,
  View,
} = React;

var FBSDKCore = require('react-native-fbsdkcore');

var {
  FBSDKAccessToken,
} = FBSDKCore;

var FBSDKLogin = require('react-native-fbsdklogin');
var {
  FBSDKLoginButton
} = FBSDKLogin;

var MK = require('react-native-material-kit');

var {
  mdl,
  MKColor,
} = MK;

var styles = StyleSheet.create(require('./styles.js'));

var styles = Object.assign(styles, StyleSheet.create({
  progress: {
    width: 125,
    //height: 2,
  },
  spinner: {
    //width: 22,
    //height: 22,
  },
}));
var SingleColorSpinner = mdl.Spinner.singleColorSpinner()
  .withStyle(styles.spinner)
  .withStrokeColor(MKColor.Pink)
  .build();


var Login = React.createClass({
  getInitialState: function() {
    return {
      token: null,
      loginText: 'Welcome! Please log in with Facebook to continue.'
    };
  },

  componentDidMount: function() {
    this.getLoginState();
  },

  getLoginState: function() {
    FBSDKAccessToken.getCurrentAccessToken((token) => {
      console.log(token);
      if(token){
        this.setState({
          token: token,
        });
      } else {
        this.setState({
          token: 'NOT_LOGGED_IN'
        });
      }
    });
  },

  render: function() {
    if (!this.state.token) {
      return this.showLoadingView();
    } else if (this.state.token === "NOT_LOGGED_IN") {
      return this.showLoginButton();
    } else {
      //change page
      return this.showLoginButton();
    }
  },

  showLoadingView: function() {
    return (
      <View style={styles.row}>
        <SingleColorSpinner/>
      </View>
    );
  },

  showLoginButton: function() {
    return (
      <View style={this.props.style}>
        <Text style={styles.disclaimerText}>{this.state.loginText}</Text>
        <FBSDKLoginButton
          style={styles.loginButton}
          onLoginFinished={(error, result) => {
            console.log(result);
            if (error) {
              this.setState({
                loginText: 'Error logging in. Please try again.'
              });
            } else {
              if (result.isCancelled) {
                this.setState({
                  loginText: 'Login cancelled.'
                });
              } else {

              }
            }
          }}
          onLogoutFinished={() => this.setState({
                loginText: 'Logged out.'
              })}
          readPermissions={['public_profile', 'user_friends', 'user_education_history', 'user_likes', 'user_work_history']}
          publishPermissions={[]}/>
      </View>
    );
  }
});

var styles = StyleSheet.create(require('./styles.js'));

module.exports = Login;
